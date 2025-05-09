import React from 'react';
import HomeScreen from '../screens/HomeScreen';
import {render} from '@testing-library/react-native';
import WeatherCurrent from '../components/WeatherCurrent';
import {View} from 'react-native';
import WeatherCoordinates from '../components/WeatherCoordinates';
import moment from 'moment';
import {displayDate} from '../general.function';

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
      jest.setSystemTime(new Date('2025-05-09T13:00:00.000Z'));
      jest.setTimeout(10000);
    });
    afterEach(() => {
      jest.useRealTimers();
    });
    test('Should Contain Real Date', () => {
      const wrapper = render(<HomeScreen />);
      const expectedDate = displayDate(moment().toDate()); // Get the formatted date from your function
      wrapper.getByText(expectedDate);
    });
    test('Should Contain Day', () => {
      const wrapper = render(<HomeScreen />);
      const expectedDay = moment().format('dddd'); // Get the formatted day from moment
      wrapper.getByText(expectedDay);
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
