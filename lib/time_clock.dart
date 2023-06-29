import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TimeClock extends StatefulWidget {
  @override
  _TimeClockState createState() => _TimeClockState();
}

class _TimeClockState extends State<TimeClock> {
  DateTime? _clockInTime;
  DateTime? _clockOutTime;
  List<DateTime> _onSiteClockInTimes = [];
  List<DateTime> _onSiteClockOutTimes = [];

  final _timeFormat = DateFormat.jm(); // jm stands for 'Hour:Minute AM/PM'
  final _dateFormat = DateFormat.yMd(); // yMd stands for 'Year-Month-Day'

  void _clockIn() {
    setState(() {
      _clockInTime = DateTime.now();
    });
  }

  void _clockOut() {
    setState(() {
      if (_onSiteClockInTimes.length > _onSiteClockOutTimes.length) {
        _onSiteClockOutTimes.add(DateTime.now());
      }
      _clockOutTime = DateTime.now();
    });
  }

  void _onSiteClockIn() {
    setState(() {
      if (_clockInTime == null) {
        _clockInTime = DateTime.now();
      }
      _onSiteClockInTimes.add(DateTime.now());
    });
  }

  void _onSiteClockOut() {
    setState(() {
      _onSiteClockOutTimes.add(DateTime.now());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Time Clock'),
      ),
      body: Center(
        child: ListView(
          padding: const EdgeInsets.all(8),
          children: <Widget>[
            Text(
              'Clock In Time: ${_formatDateTime(_clockInTime)}',
            ),
            ElevatedButton(
              onPressed: _clockIn,
              child: Text('Clock In'),
              style: ElevatedButton.styleFrom(
                primary: Colors.green, // background color
              ),
            ),
            ..._buildOnSiteTimes(),
            ElevatedButton(
              onPressed: _onSiteClockIn,
              child: Text('On Site Clock In'),
              style: ElevatedButton.styleFrom(
                primary: Colors.green, // background color
              ),
            ),
            ElevatedButton(
              onPressed: _onSiteClockOut,
              child: Text('On Site Clock Out'),
              style: ElevatedButton.styleFrom(
                primary: Colors.red, // background color
              ),
            ),
            Text(
              'Clock Out Time: ${_formatDateTime(_clockOutTime)}',
            ),
            ElevatedButton(
              onPressed: _clockOut,
              child: Text('Clock Out'),
              style: ElevatedButton.styleFrom(
                primary: Colors.red, // background color
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildOnSiteTimes() {
    List<Widget> onSiteTimes = [];
    for (int i = 0; i < _onSiteClockInTimes.length; i++) {
      onSiteTimes.add(Text('Site ${i + 1} Clock In Time: ${_formatDateTime(_onSiteClockInTimes[i])}'));
      if (i < _onSiteClockOutTimes.length) {
        onSiteTimes.add(Text('Site ${i + 1} Clock Out Time: ${_formatDateTime(_onSiteClockOutTimes[i])}'));
      }
    }
    return onSiteTimes;
  }

  String _formatDateTime(DateTime? dateTime) {
    if (dateTime == null) {
      return "";
    } else {
      return '${_dateFormat.format(dateTime)} ${_timeFormat.format(dateTime)}';
    }
  }
}
