import React from 'react';
import HomeScreen from '../screens/HomeScreen';
import {render} from '@testing-library/react-native';
import WeatherCurrent from '../components/WeatherCurrent';
import {View} from 'react-native';
import WeatherCoordinates from '../components/WeatherCoordinates';

jest.mock('../components/WeatherCurrent', () =>
  jest.fn().mockReturnValue(null),
);
jest.mock('../components/WeatherCoordinates', () =>
  jest.fn().mockReturnValue(null),
);

describe('Home Screen', () => {
  test('Should render Home Screen', () => {
    const wrapper = render(<HomeScreen />);
    wrapper.getByTestId('home-screen');
  });

  describe('Title Sections', () => {
    beforeEach(() => {
      jest.useFakeTimers('modern');
      jest.setTimeout(10000);
    });
    afterEach(() => {
      jest.useRealTimers();
    });
    test('Should Contain Real Date', () => {
      const wrapper = render(<HomeScreen />);
      wrapper.getByText('May 09, 2025');
    });
    test('Should Contain Day', () => {
      const wrapper = render(<HomeScreen />);
      wrapper.getByText('Friday');
    });
  });

  test('Should contain a section to get current weather', () => {
    (WeatherCurrent as jest.Mock).mockReturnValue(
      <View testID={'mock-weather-current'} />,
    );
    const wrapper = render(<HomeScreen />);
    wrapper.getByTestId('mock-weather-current');
  });

  test('Should contain a section to get coordinate weather', () => {
    (WeatherCoordinates as jest.Mock).mockReturnValue(
      <View testID={'mock-weather-coordinate'} />,
    );
    const wrapper = render(<HomeScreen />);
    wrapper.getByTestId('mock-weather-coordinate');
  });
});
