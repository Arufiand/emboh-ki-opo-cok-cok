import LocationService from '../locationService';

describe('LocationService', () => {
  test('should return a location', async () => {
    const expectedLatitude = -6.212;
    const expectedLongitude = 106.833;
    const tolerance = 0.001; // Define a small tolerance for comparison

    const position = await LocationService.getCurrentPosition();
    console.log(JSON.stringify(position, null, 2));
    expect(position.latitude).toBeCloseTo(expectedLatitude, 3); // Check within 3 decimal places
    expect(position.longitude).toBeCloseTo(expectedLongitude, 3); // Check within 3 decimal places
  });
});
