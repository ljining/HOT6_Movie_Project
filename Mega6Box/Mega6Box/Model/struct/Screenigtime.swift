
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

//컬렉션뷰 셀잡히게 하려고 테스트데이터
struct Day {
    let date: String
}
//엔티티 > 속성 > 앱델리게잇에서 스택을 구현하고 > 컨텐트를 만들어서(사용할때만-인스턴스로만들어짐) > 컨텐트안에 내용을 넣어야함 >
extension Day {
    static var data = [
    Day(date: "1"),
    Day(date: "2"),
    Day(date: "3"),
    Day(date: "4"),
    Day(date: "5"),
    ]
   
}


