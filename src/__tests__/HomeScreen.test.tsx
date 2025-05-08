import React from 'react';
import HomeScreen from '../HomeScreen';
import {render} from '@testing-library/react-native';

describe('Home Screen', () => {
  test('Should render Home Screen', () => {
    const wrapper = render(<HomeScreen />);
    wrapper.getByTestId('home-screen');
  });
});
