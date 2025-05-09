import React from 'react';
import {StyleSheet, Text, View} from 'react-native';
import LinearGradient from 'react-native-linear-gradient';
import {Colors} from '../constants';
import moment from 'moment';

function displayDate(date: Date) {
  const today = date.getDate();
  const month = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ][date.getMonth()];

  return `${month} ${today < 10 && '0'}${today}, ${date.getFullYear()}`;
}

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
