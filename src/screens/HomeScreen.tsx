import React from 'react';
import {StyleSheet, Text, View} from 'react-native';
import LinearGradient from 'react-native-linear-gradient';
import {Colors} from '../utils/constants';
import moment from 'moment';
import WeatherCurrent from '../components/WeatherCurrent';
import WeatherCoordinates from '../components/WeatherCoordinates';
import {displayDate} from '../utils/helpers';

function HomeScreen() {
  return (
    <LinearGradient
      colors={[Colors.LIGHT_GREY, Colors.DARKER_GREY]}
      testID="home-screen"
      style={styles.container}>
      <View style={styles.title}>
        <Text style={styles.date}>{displayDate(moment().toDate())}</Text>
        <Text style={styles.day}>{moment().format('dddd')}</Text>
      </View>
      <WeatherCurrent />
      <WeatherCoordinates />
    </LinearGradient>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    paddingHorizontal: 40,
    alignContent: 'space-between',
    justifyContent: 'space-around',
  },
  title: {
    justifyContent: 'flex-end',
  },
  date: {
    color: Colors.GRAY,
  },
  day: {
    color: Colors.WHITE,
  },
});

export default HomeScreen;
