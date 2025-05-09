export function displayDate(date: Date) {
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

  return `${month} ${today < 10 ? '0' : ''}${today}, ${date.getFullYear()}`;
}
