import React from 'react';
import HomeScreen from '../screens/HomeScreen';
import {render} from '@testing-library/react-native';

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
});
