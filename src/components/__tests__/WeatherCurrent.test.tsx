import React from 'react';
import {render} from '@testing-library/react-native';
import WeatherCurrent from '../WeatherCurrent';

describe('Weather Current', () => {
  test('Should render Weather Current Component', () => {
    const wrapper = render(<WeatherCurrent />);
    wrapper.getByTestId('weather-current');
  });

  test('Should navigate to weather screen with location', () => {
    throw new Error('Not implemented');
  });
});
