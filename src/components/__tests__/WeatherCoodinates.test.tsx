import React from 'react';
import {render} from '@testing-library/react-native';
import WeatherCoordinates from '../WeatherCoordinates';

describe('Weather Coordinates', () => {
  test('Should render Weather Coordinates Component', () => {
    const wrapper = render(<WeatherCoordinates />);
    wrapper.getByTestId('weather-coordinates');
  });
});
