import express, { type Request, type Response } from 'express';
import cookieParser from 'cookie-parser';
import crypto from 'crypto';
import { pool, initDatabase } from './db.js';

const app = express();
app.use(express.json());
app.use(cookieParser());

// --- Simulated Database ---
interface Product {
    id: string;
    name: string;
    price: number;
    availableSeats: number;
}

const products: Record<string, Product> = {
    'vip-pass': { id: 'vip-pass', name: 'VIP Concert Pass', price: 200, availableSeats: 1 },
    'regular-pass': { id: 'regular-pass', name: 'General Admission', price: 80, availableSeats: 50 },
};

const bookings: Array<{ id: string; productId: string; userId: string; timestamp: number }> = [];

// --- Custom CORS Setup ---
app.use((req, res, next) => {
    res.setHeader('Access-Control-Allow-Origin', '*');
    res.setHeader('Access-Control-Allow-Headers', 'Content-Type, Authorization');
    res.setHeader('Access-Control-Allow-Methods', 'GET, POST, OPTIONS');
    if (req.method === 'OPTIONS') {
        return res.sendStatus(200);
    }
    next();
});

// Route 1: Heavy/Laggy endpoint (Simulating 5s query & CPU load)
app.get('/api/analytics', (req: Request, res: Response) => {
    const heavySalt = crypto.randomBytes(16).toString('hex');
    crypto.pbkdf2Sync('heavy-load-token', heavySalt, 80000, 64, 'sha512');

    setTimeout(() => {
        res.json({
            activeVisitors: Math.floor(Math.random() * 500) + 100,
            totalSalesVolume: 18450,
            serverTime: new Date().toISOString(),
        });
    }, 5000);
});

// Route 2: Get Catalog
app.get('/api/products', (req: Request, res: Response) => {
    res.json(Object.values(products));
});

// Route 3: Admin update price
app.post('/api/admin/update-price', (req: Request, res: Response) => {
    const { productId, newPrice } = req.body;
    if (!products[productId]) {
        return res.status(404).json({ error: 'Product not found' });
    }
    products[productId].price = newPrice;
    res.json({ message: 'Price updated successfully', product: products[productId] });
});

// Route 4: Vulnerable Checkout (Trusts client price)
app.post('/api/checkout', (req: Request, res: Response) => {
    const { cartItems } = req.body;

    if (!cartItems || cartItems.length === 0) {
        return res.status(400).json({ error: 'Cart is empty' });
    }

    const total = cartItems.reduce(
        (acc: number, item: { price: number; qty: number }) => acc + item.price * item.qty,
        0
    );

    res.json({
        orderId: `ORD-${Date.now()}`,
        status: 'CONFIRMED',
        chargedAmount: total,
    });
});

// Route 5: Seat Booking via PostgreSQL (Check-Then-Act Race Condition)
app.post('/api/book-seat', async (req: Request, res: Response) => {
    const { productId, userId } = req.body;

    try {
        const checkResult = await pool.query(
            'SELECT id, status FROM seats WHERE id = $1',
            [productId]
        );

        const seat = checkResult.rows[0];
        if (!seat) return res.status(404).json({ error: 'Seat not found' });
        if (seat.status !== 'AVAILABLE') {
            return res.status(400).json({ error: 'Sold out! Seat already reserved.' });
        }

        // Artificial processing delay that opens race condition window
        await new Promise((resolve) => setTimeout(resolve, 300));

        await pool.query(
            'UPDATE seats SET status = $1, booked_by = $2 WHERE id = $3',
            ['BOOKED', userId, productId]
        );

        res.json({ message: 'Seat successfully reserved!', bookedBy: userId });
    } catch (error: any) {
        res.status(500).json({ error: error.message });
    }
});

// Route 6: Protected User Profile
app.get('/api/user/profile', (req: Request, res: Response) => {
    const session = req.cookies['session_token'];
    if (!session) {
        return res.status(401).json({ error: 'Unauthorized: Missing session cookie' });
    }
    res.json({ username: 'engineer_one', role: 'attendee' });
});

// Healthcheck
app.get('/api/health', (req: Request, res: Response) => {
    res.json({ status: 'healthy', uptime: process.uptime() });
});

// Initialize DB and start server
initDatabase().then(() => {
    app.listen(5000, () => {
        console.log('Backend running on http://localhost:5000');
    });
});
