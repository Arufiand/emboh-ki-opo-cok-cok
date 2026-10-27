import { useState, useEffect } from 'react';

interface AnalyticsData {
  activeVisitors: number;
  totalSalesVolume: number;
  serverTime: string;
}

interface UserProfile {
  username: string;
  role: string;
}

interface CartItem {
  id: string;
  price: number;
  qty: number;
}

export default function App() {
  const [selectedProductId, setSelectedProductId] = useState('vip-pass');
  const [cart, setCart] = useState<CartItem[]>([]);
  const [analytics, setAnalytics] = useState<AnalyticsData | null>(null);
  const [userProfile, setUserProfile] = useState<UserProfile | null>(null);
  const [checkoutResult, setCheckoutResult] = useState<string>('');
  const [bookingResult, setBookingResult] = useState<string>('');
  const [authError, setAuthError] = useState<string>('');

  // Object defined in render body without useMemo (triggers the re-render dependency behavior)
  // eslint-disable-next-line react-hooks/exhaustive-deps
  const query = { type: 'realtime' };

  useEffect(() => {
    fetch('http://localhost:5000/api/analytics')
        .then((res) => res.json())
        .then((data: AnalyticsData) => setAnalytics(data))
        .catch((err: unknown) => console.error(err));
  }, [query]);

  const addToCart = (id: string, price: number) => {
    setCart([{ id, price, qty: 1 }]);
  };

  const handleCheckout = async () => {
    const res = await fetch('http://localhost:5000/api/checkout', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ cartItems: cart }),
    });
    const data: unknown = await res.json();
    setCheckoutResult(JSON.stringify(data));
  };

  const handleBooking = async (userId: string) => {
    const res = await fetch('http://localhost:5000/api/book-seat', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ productId: 'vip-pass', userId }),
    });
    const data: unknown = await res.json();
    setBookingResult((prev) => `${prev}\n[${userId}]: ${JSON.stringify(data)}`);
  };

  const fetchProfile = async () => {
    try {
      const res = await fetch('http://localhost:5000/api/user/profile', {
        headers: { 'Content-Type': 'application/json' },
        credentials: 'include',
      });
      if (!res.ok) {
        setAuthError(`HTTP ${res.status}`);
        return;
      }
      const data = (await res.json()) as UserProfile;
      setUserProfile(data);
      setAuthError('');
    } catch (err: unknown) {
      if (err instanceof Error) {
        setAuthError(err.message);
      } else {
        setAuthError('An unknown error occurred');
      }
    }
  };

  return (
      <div style={{ fontFamily: 'sans-serif', padding: 24, maxWidth: 900, margin: '0 auto' }}>
        <h2>Concert Ticket Engine & Platform Lab</h2>
        <hr />

        {/* Analytics Area */}
        <section style={{ margin: '16px 0', padding: 12, background: '#f5f5f5', borderRadius: 6 }}>
          <h3>Dashboard Analytics</h3>
          <p>{analytics ? `Active Visitors: ${analytics.activeVisitors}` : 'Loading analytics (takes 5s)...'}</p>
        </section>

        {/* Product Selection Tab */}
        <section style={{ margin: '16px 0' }}>
          <h3>Ticket Switcher</h3>
          <button onClick={() => setSelectedProductId('vip-pass')}>Select VIP Pass</button>
          <button onClick={() => setSelectedProductId('regular-pass')} style={{ marginLeft: 8 }}>
            Select Regular Pass
          </button>

          <TicketDetail productId={selectedProductId} onAddToCart={addToCart} />
        </section>

        {/* Cart & Checkout */}
        <section style={{ margin: '16px 0', border: '1px solid #ccc', padding: 12 }}>
          <h3>Cart</h3>
          <p>Items in Cart: {cart.length > 0 ? `${cart[0].id} @ ₹${cart[0].price}` : 'Empty'}</p>
          <button disabled={cart.length === 0} onClick={handleCheckout}>
            Checkout Now
          </button>
          {checkoutResult && <pre>{checkoutResult}</pre>}
        </section>

        {/* Concurrency Booking */}
        <section style={{ margin: '16px 0', border: '1px solid #ccc', padding: 12 }}>
          <h3>Simulate Simultaneous Booking</h3>
          <button onClick={() => handleBooking('User_Alice')}>Book as Alice</button>
          <button onClick={() => handleBooking('User_Bob')} style={{ marginLeft: 8 }}>Book as Bob</button>
          <pre>{bookingResult}</pre>
        </section>

        {/* Profile & Auth */}
        <section style={{ margin: '16px 0', border: '1px solid #ccc', padding: 12 }}>
          <h3>User Profile (CORS & Cookie test)</h3>
          <button onClick={fetchProfile}>Load Profile</button>
          {authError && <p style={{ color: 'red' }}>Error: {authError}</p>}
          {userProfile && <pre>{JSON.stringify(userProfile, null, 2)}</pre>}
        </section>
      </div>
  );
}

function TicketDetail({ productId, onAddToCart }: { productId: string; onAddToCart: (id: string, price: number) => void }) {
  const [customDiscountCode, setCustomDiscountCode] = useState(`CODE_FOR_${productId}`);
  const price = productId === 'vip-pass' ? 200 : 80;

  return (
      <div style={{ marginTop: 12, padding: 12, background: '#eef2ff' }}>
        <h4>Active View: {productId.toUpperCase()} (₹{price})</h4>
        <label>
          Promo Note:
          <input
              value={customDiscountCode}
              onChange={(e) => setCustomDiscountCode(e.target.value)}
              style={{ marginLeft: 8 }}
          />
        </label>
        <div style={{ marginTop: 8 }}>
          <button onClick={() => onAddToCart(productId, price)}>Add to Cart</button>
        </div>
      </div>
  );
}
