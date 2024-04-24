
import Foundation

struct Screenigtime {
    let time: String
    let seat: String
}

//상영시간 더미데이터
extension Screenigtime {
    static var data = [
        Screenigtime(time: "09:00 ~ 10:59",seat: "170/220석"),
        Screenigtime(time: "09:40 ~ 11:39",seat: "89/101석"),
        Screenigtime(time: "10:15 ~ 12:14",seat: "96/96석"),
        Screenigtime(time: "10:50 ~ 12:49",seat: "70/94석"),
        Screenigtime(time: "11:20 ~ 13:19",seat: "220/221석"),
        Screenigtime(time: "12:00 ~ 13:59",seat: "137/137석"),
        Screenigtime(time: "12:35 ~ 14:34",seat: "223/225석"),
        Screenigtime(time: "13:10 ~ 15:09",seat: "187/190석"),
    ]
}

