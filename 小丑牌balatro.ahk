#Requires AutoHotkey v2.0
#NoTrayIcon
if !DirExist("bin") {
    DirCreate "bin"
    FileInstall "向右箭头.png", "bin/向右箭头.png"
    FileInstall "向左箭头.png", "bin/向左箭头.png"
    FileInstall "小丑牌 (1).png", "bin/小丑牌 (1).png"
    FileInstall "小丑牌 (2).png", "bin/小丑牌 (2).png"
    FileInstall "问号.png", "bin/问号.png"
    sleep 2000
    MsgBox "ok"
    Reload()
}
SetWorkingDir A_ScriptDir
; FileInstall "小丑牌 (1).png",".\bin\"
neww := Gui()
neww.Opt("-DPIScale -MaximizeBox") neww.MarginX := 0 neww.MarginY := 0
neww.Title := "小丑牌balatro.exe"
try {
    mainpic := neww.AddPicture("w-1 h600 x0 y0", "bin/小丑牌 (1).png")
    ; mainpic := neww.AddPicture("w-1 h400 x0 y0", "HBITMAP:*" LoadPicture("小丑牌balatro.exe"))
    neww.AddPicture("w-1 h40  ys", "bin\问号.png").OnEvent("Click", (*) => MsgBox(longtext))
    neww.AddText("xp w50 h40 wrap", "快捷键示例").OnEvent("Click", (*) => MsgBox(longtext))
    neww.AddPic("w-1 h40 xp", "bin/向左箭头.png").OnEvent("click", (*) => mainpic.Value := "bin/小丑牌 (1).png")
    neww.AddPic("w-1 h40 xp", "bin/向右箭头.png").OnEvent("click", (*) => mainpic.Value := "bin/小丑牌 (2).png")
}

neww.OnEvent("Close", (*) => ExitApp())
neww.Show()
CoordMode 'Mouse', 'Screen'
shuffle := { 点数: [1012, 960], 花色: [1080, 960], 比赛信息: [153, 779]
    , 盲注: [935, 162], 出牌: [826, 976], 弃牌: [1244, 953]
    , 选项: [144, 952], 开始新的一局: [1063, 360], 开始游戏: [960, 824], 查看牌堆: [1653, 953], 下一回合: [689, 451]
    , 小盲注: [698, 388], 大盲注: [1038, 388], 特大盲注: [1384, 388]
    , 小盲注跳过: [698, 835], 大盲注跳过: [1038, 835], 主菜单: [953, 452]
}
cl(px, py) {
    MouseMove(px, py, 0)
    Sleep 100
    MouseClick
}
#HotIf WinActive("小丑牌balatro.exe")
WheelUp:: mainpic.Value := "bin/小丑牌 (1).png"
WheelDown:: mainpic.Value := "bin/小丑牌 (2).png"
#HotIf

#HotIf WinActive("Balatro")
#SuspendExempt true
MButton:: Suspend
#SuspendExempt false
toggle := true

;切换花色或点数
RButton:: {
    toggle ? cl(shuffle.点数[1], shuffle.点数[2]) : cl(shuffle.花色[1], shuffle.花色[2])
    global toggle := !toggle
}
;下注信息
Tab:: {
    cl(shuffle.比赛信息[1], shuffle.比赛信息[2])
    Sleep 200
    cl(shuffle.盲注[1], shuffle.盲注[2])
}
WheelUp:: cl(shuffle.出牌[1], shuffle.出牌[2])
WheelDown:: cl(shuffle.弃牌[1], shuffle.弃牌[2])
;重开
Enter:: {
    cl(shuffle.选项[1], shuffle.选项[2])
    Sleep 200
    cl(shuffle.开始新的一局[1], shuffle.开始新的一局[2])
    Sleep 200
    cl(shuffle.开始游戏[1], shuffle.开始游戏[2])
}
Ctrl:: cl(shuffle.查看牌堆[1], shuffle.查看牌堆[2])
;下一关
q:: cl(shuffle.小盲注[1], shuffle.小盲注[2])
w:: cl(shuffle.大盲注[1], shuffle.大盲注[2])
e:: cl(shuffle.特大盲注[1], shuffle.特大盲注[2])
d:: cl(shuffle.小盲注跳过[1], shuffle.小盲注跳过[2])
f:: cl(shuffle.大盲注跳过[1], shuffle.大盲注跳过[2])
;下一回合
Space:: cl(shuffle.下一回合[1], shuffle.下一回合[2])
;读档
s:: {
    Send("{Escape}")
    Sleep 200
    cl(shuffle.主菜单[1], shuffle.主菜单[2])
}
;开始游戏
a:: {
    ;点击两次开始游戏按钮
    cl(534, 925)
    Sleep 150
    cl(968, 826)
}

longtext :=
    (
        "
        游戏中按F1可调出帮助菜单
        （所有快捷键都是游戏中才有用）
        **********************键盘快捷键**************************************
        初始界面按下A 即可快速开始游戏 
        回车键重开游戏（'注意是新的一局游戏'）
        游戏结束之后（失败后） 按下F + A（等回到开始界面再按下A）即可快速开始新游戏
        Q、W、E 选择对应按钮 Q-->选择小盲注 W-->选择大盲注 E-->进入boss战
        D、F -->跳过小、大盲注
        按下 S 快速返回主界面 配合A键 S + A实现读档
        TAB 查看当前盲注消息
        空格键 下一回合（在商店界面使用）
        Ctrl键 查看牌堆
        ***********************鼠标操作快捷键：*********************************
        鼠标右键快速切换花色 （再次按下切换另一种花色）
        鼠标滚轮向上-- > 出牌
        鼠标滚轮向下-- > 弃牌
        按下鼠标滚轮（鼠标中键） 暂停使用脚本 再次按下鼠标滚轮启用脚本
        （这个一般用不到 因为快捷键只在小丑牌界面会触发）
        "
    )
;帮助信息
F1:: MsgBox longtext

#HotIf