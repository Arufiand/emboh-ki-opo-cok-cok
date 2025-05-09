import LocationService from '../locationService';

describe('LocationService', () => {
  test('should return a location', async () => {
    const position = await LocationService.getCurrentPosition();
    expect(position).toEqual({
      latitude: 0,
      longitude: 0,
    });
  });
});
