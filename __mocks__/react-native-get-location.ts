function getCurrentPosition() {
  return Promise.resolve({
    // latitude: 0,
    // longitude: 0,
    // altitude: 0,
    // accuracy: 0,
    // speed: 0,
    // time: 0,
    // bearing: 0,
    // provider: 0,
    // verticalAccuracy: 0,
    // course: 0,
    latitude: -6.212, // Slightly adjusted from your value
    longitude: 106.833, // Slightly adjusted from your value
    altitude: 10,
    accuracy: 5,
    speed: 0,
    time: Date.now(),
    bearing: 0,
    provider: 'mock',
    verticalAccuracy: 10,
    course: 0,
  });
}

export default {getCurrentPosition};
