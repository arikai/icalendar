#stream = File.read!("test/fixtures/blank_description.ics")
    stream = ~s"""
    BEGIN:VEVENT
    DTSTART:20170419T091500Z
    DTEND:20170419T102500Z
    UID:00U5E000001JfN7UAK
    DESCRIPTION:some HTML in here
    LOCATION:here
    STATUS:CONFIRMED
    SUMMARY:test reminder2
    RDATE;VALUE=PERIOD:19960403T020000Z/19960403T040000Z,
     19960404T010000Z/PT3H
    END:VEVENT
    """
{:ok, decoded} = ICalendar.Decoder.decode(stream)
IO.inspect decoded

%{
  __type__: :event,
  description: {"some HTML in here", %{}, :text},
  dtend: {#DateTime<2017-04-19 10:25:00Z>, %{}, :date_time},
  dtstart: {#DateTime<2017-04-19 09:15:00Z>, %{}, :date_time},
  location: {"here", %{}, :text},
  rdate: {[
     %Timex.Interval{
       from: ~N[1996-04-03 02:00:00],
       left_open: false,
       right_open: true,
       step: [days: 1],
       until: ~N[1996-04-03 04:00:00]
     },
     %Timex.Interval{
       from: ~N[1996-04-04 01:00:00],
       left_open: false,
       right_open: true,
       step: [days: 1],
       until: ~N[1996-04-04 04:00:00]
     }
   ], %{}, :period},
  status: {"CONFIRMED", %{}, :text},
  summary: {"test reminder2", %{}, :text},
  uid: {"00U5E000001JfN7UAK", %{}, :text}
}
#:eflame.apply(ICalendar.Decoder, :decode, [stream])
#ICalendar.Encoder.encode(decoded)
#

Benchee.run(%{
  "decode"    => fn -> ICalendar.Decoder.decode(stream) end,
  "encode"    => fn -> ICalendar.Encoder.encode(decoded) end,
}, time: 10)
stream = "BEGIN:VCALENDAR\nPRODID:-//Google Inc//Google Calendar 70.9054//EN\nVERSION:2.0\nCALSCALE:GREGORIAN\nX-WR-CALNAME:calmozilla1@gmail.com\nX-WR-TIMEZONE:America/Los_Angeles\nBEGIN:VTIMEZONE\nTZID:America/Los_Angeles\nX-LIC-LOCATION:America/Los_Angeles\nBEGIN:DAYLIGHT\nTZOFFSETFROM:-0800\nTZOFFSETTO:-0700\nTZNAME:PDT\nDTSTART:19700308T020000\nRRULE:FREQ=YEARLY;BYMONTH=3;BYDAY=2SU\nEND:DAYLIGHT\nBEGIN:STANDARD\nTZOFFSETFROM:-0700\nTZOFFSETTO:-0800\nTZNAME:PST\nDTSTART:19701101T020000\nRRULE:FREQ=YEARLY;BYMONTH=11;BYDAY=1SU\nEND:STANDARD\nEND:VTIMEZONE\nBEGIN:VEVENT\nDTSTART;TZID=America/Los_Angeles:20120630T060000\nDTEND;TZID=America/Los_Angeles:20120630T070000\nDTSTAMP:20120724T212411Z\nUID:dn4vrfmfn5p05roahsopg57h48@google.com\nCREATED:20120724T212411Z\nDESCRIPTION:\nLAST-MODIFIED:20120724T212411Z\nLOCATION:\nSEQUENCE:0\nSTATUS:CONFIRMED\nSUMMARY:Really long event name thing\nTRANSP:OPAQUE\nBEGIN:VALARM\nACTION:EMAIL\nDESCRIPTION:This is an event reminder\nSUMMARY:Alarm notification\nATTENDEE:mailto:calmozilla1@gmail.com\nTRIGGER:-P0DT0H30M0S\nEND:VALARM\nBEGIN:VALARM\nACTION:DISPLAY\nDESCRIPTION:This is an event reminder\nTRIGGER:-P0DT0H30M0S\nEND:VALARM\nEND:VEVENT\nEND:VCALENDAR\n"
