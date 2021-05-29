module AttendancesHelper

  def attendance_state(attendance)
    # 受け取ったAttendanceオブジェクトが当日と一致するか評価します。
    if Date.current == attendance.worked_on
      return '出勤' if attendance.started_at.nil?
      return '休憩IN' if attendance.started_at.present? && attendance.rest_in_at.nil?
      return '休憩OUT' if attendance.rest_in_at.present? && attendance.rest_out_at.nil?
      return '退勤' if attendance.started_at.present? && attendance.finished_at.nil?
    end
    
    return false
  end


  # 出勤時間と退勤時間を受け取り、在社時間を計算して返します。
  def working_times(start, finish)
    format("%.2f", (((finish - start) / 60) / 60.0))
  end
  
  def rest_times(rest_in, rest_out)
    format("%.2f", (((rest_out - rest_in) / 60) / 60.0))
  end
  
  def day_total_working_times(start, finish, rest_in, rest_out)
    format("%.2f", ((((finish - start) - (rest_out - rest_in)) / 60) / 60.0))
  end
  
  def zangyo_times
    format("%.2f", ((28800 / 60) /60.0))
  end
  
  def night_times
    format("%.2f", ((79200 / 60) /60.0))
  end
end