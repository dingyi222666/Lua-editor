require "import"
require "Pretend"
import "android.content.Context"
import "android.app.*"
import "android.os.*"
import "android.widget.*"
import "android.view.*"
import 'java.text.SimpleDateFormat'
import 'java.util.Date'
import "mods.func"
import "mods.io"
import "java.io.File"
import "res.string"
通知栏颜色(读取颜色())
local L2_2,L1_1
L0_0 = {L1_1, L2_2}
L1_1 = LinearLayout
L0_0.orientation = "vertical"
L0_0.layout_width = "fill"
L0_0.layout_height = "fill"
L0_0.gravity = "center"
L2_2.orientation = "horizontal"
L2_2.layout_width = "fill"
L2_2.layout_height = "55dp"
L5_5 = ImageView
L4_4.layout_width = "32dp"
L4_4.layout_height = "32dp"
L4_4.id = "icon"
L4_4.layout_gravity = "center"
L4_4.layout_marginLeft = "8dp"
L5_5 = {L6_6}
L6_6 = TextView
L5_5.layout_marginLeft = "8dp"
L5_5.text = "文本内容"
L5_5.textSize = "16sp"
L5_5.textColor = "#ffffff"
L5_5.id = "name"
L5_5.gravity = "left|center"
L5_5.layout_gravity = "left|center"
L5_5.ellipsize = "end"
L5_5.lines = "1"
item = L0_0

L0_0 = import
L1_1 = "com.androlua.LuaUtil"
L0_0(L1_1)
function getMD5(A0_12)
  local L1_13, L2_14
  L1_13 = _ENV
  L2_14 = L1_13.tostring
  return L2_14(L1_13.LuaUtil.getFileMD5(L1_13.tostring(A0_12)))
end
function GetFilelastTime(A0_15)
  local L1_16
  L1_16 = _ENV
  L1_16.f = L1_16.File(A0_15)
  L1_16.cal = L1_16.Calendar.getInstance()
  L1_16.time = L1_16.f.lastModified()
  L1_16.cal.setTimeInMillis(L1_16.time)
  return L1_16.SimpleDateFormat("yyyy.MM.dd HH:mm:ss").format(L1_16.cal.getTime())
end
function GetFileSize(A0_17)
  local L1_18
  L1_18 = _ENV
  L1_18.import("java.io.File")
  L1_18.import("android.text.format.Formatter")
  L1_18.size = L1_18.File(L1_18.tostring(A0_17)).length()
  L1_18.Sizes = L1_18.Formatter.formatFileSize(L1_18.activity, L1_18.size)
  return L1_18.Sizes
end


adp =LuaAdapter( activity,item)
function L0_0(A0_19)
  local L1_20
  L1_20 = _ENV
  L1_20.dir = A0_19
  L1_20.adp.clear()
  L1_20.ls = L1_20.luajava.astable(A0_19.listFiles() or L1_20.String({}))
  L1_20.table.sort(L1_20.ls, function(A0_21, A1_22)
    local L2_23
    L2_23 = L1_20
    return A0_21.isDirectory() ~= A1_22.isDirectory() and A0_21.isDirectory() or A0_21.isDirectory() == A1_22.isDirectory() and A0_21.Name < A1_22.Name
  end)
  L1_20.adp.add({
    icon = {
      src = "image/dir.png",
      ColorFilter = L1_20.tonumber(L1_20["读取颜色"]())
    },
    name = "../",
    xx = [[



]]
  })
  L1_20.Filepath.Text = L1_20.tostring(A0_19)
  for _FORV_5_ = 1, #L1_20.ls do
    if L1_20.ls[_FORV_5_].isDirectory() then
      L1_20.adp.add({
        icon = {
          src = "image/dir.png",
          ColorFilter = L1_20.tonumber(L1_20["读取颜色"]())
        },
        name = {
          text = L1_20.ls[_FORV_5_].Name,
          textColor = L1_20["读取文字颜色"](1)
        }
      })
     else
      L1_20.adp.add({
        icon = {
          src = "image/file.png",
          ColorFilter = L1_20.tonumber(L1_20["读取颜色"]())
        },
        name = {
          text = L1_20.ls[_FORV_5_].Name,
          textColor = L1_20["读取文字颜色"](1)
        }
      })
    end
  end
end
show = L0_0
L0_0 = list
L1_1 = adp
L0_0.Adapter = L1_1
L0_0 = import
L1_1 = "java.io.File"
L0_0(L1_1)
function L0_0(A0_24)
  local L1_25, L2_26
  L1_25 = _ENV
  function L2_26(A0_27)
    local L1_28
    L1_28 = L1_25
    L1_28.require("import")
    L1_28.import("java.io.File")
    L1_28.import("java.text.SimpleDateFormat")
    L1_28.import("java.util.Date")
    L1_28.Thread.sleep(100)
    L1_28.call("show", L1_28.File(A0_27))
  end
  L1_25.thread(L2_26, A0_24)
end
_ENV["加载"] = L0_0
L0_0 = list
function L1_1(A0_29, A1_30, A2_31, A3_32)
  local L4_33, L5_34, L6_35, L7_36, L8_37, L9_38
  L4_33 = _ENV
  L5_34 = A1_30.Tag
  L5_34 = L5_34.name
  L5_34 = L5_34.Text
  if L5_34 == "../" then
    L5_34 = L4_33.Filepath
    L5_34 = L5_34.Text
    if L5_34 == "/" then
      L5_34 = L4_33["提示"]
      L5_34(L6_35)
     else
      L5_34 = L4_33.show
      L5_34(L6_35)
    end
   else
    L5_34 = L4_33.ls
    L5_34 = L5_34[A2_31]
    L5_34 = L5_34.isDirectory
    L5_34 = L5_34()
    if L5_34 then
      L5_34 = L4_33.show
      L5_34(L6_35)
     else
      L5_34 = L4_33.ls
      L5_34 = L5_34[A2_31]
      L5_34 = L5_34.isFile
      L5_34 = L5_34()
      if L5_34 then
        L5_34 = L4_33.tostring
        L5_34 = L5_34(L6_35)
        L5_34 = L5_34.find
        L5_34 = L5_34(L6_35, L7_36)
        if L5_34 then
          L5_34 = L4_33.io
          L5_34 = L5_34.open
          L5_34 = L5_34(L6_35)
          L5_34 = L5_34.read
          L5_34 = L5_34(L6_35, L7_36)
          L9_38 = "\n"
          L6_35(L7_36)
          L9_38 = L4_33.ls
          L9_38 = L9_38[A2_31]
          L9_38 = L8_37(L9_38)
          L9_38 = "*a"
          L9_38 = L7_36(L8_37, L9_38)
          if L6_35 == 27 then
            L9_38 = L4_33.ls
            L9_38 = L9_38[A2_31]
            L6_35(L7_36)
            return
           else
            L9_38 = L7_36(L8_37)
            L9_38 = "(.+)\n"
            if L7_36 == nil then
              L9_38 = L6_35
              if L8_37 == "=" then
                if L8_37 > 100 then
                  L9_38 = "不能打开已编译文件 "
                  L9_38 = L9_38 .. L4_33.tostring(L4_33.ls[A2_31])
                  L8_37(L9_38)
                  return
                end
              end
            end
          end
          L9_38 = L4_33.ls
          L9_38 = L9_38[A2_31]
          L9_38 = L8_37(L9_38)
          L9_38 = "*a"
          L6_35.Text = L7_36
          for L9_38, _FORV_10_ in L6_35(L7_36) do
            if _FORV_10_ == L4_33.tostring(L4_33.ls[A2_31]) then
              L4_33.is = true
              break
            end
          end
          if L6_35 ~= true then
            L9_38 = L8_37()
            L9_38 = L4_33.ls
            L9_38 = L9_38[A2_31]
            L9_38 = L8_37(L9_38)
            L6_35(L7_36, L8_37, L9_38, L8_37(L9_38))
           else
            for L9_38 = 0, L7_36 - 1 do
              if L4_33.opentab[L4_33.sd.getChildAt(L9_38).id] == L4_33.tostring(L4_33.ls[A2_31]) then
                L4_33.sd.getChildAt(L9_38).setTextColor(3006674486)
               else
                L4_33.sd.getChildAt(L9_38).setTextColor(4294967295)
              end
            end
          end
          L9_38 = L4_33.ls
          L9_38 = L9_38[A2_31]
          L9_38 = L8_37(L9_38)
          L6_35(L7_36)
          L6_35(L7_36)
        end
      end
    end
  end
  L5_34 = true
  return L5_34
end
L0_0.onItemClick = L1_1
L0_0 = list
function L1_1(A0_39, A1_40, A2_41, A3_42)
  local L4_43
  L4_43 = _ENV
  if A1_40.Tag.name.Text ~= "../" then
    L4_43.AlertDialog.Builder(L4_43.this).setTitle(A1_40.Tag.name.Text).setItems({"重命名", "删除"}, {
      onClick = function(A0_44, A1_45)
        local L2_46
        L2_46 = L4_43
        if A1_45 == 0 then
          L2_46["提示"]("在做了")
         else
          L2_46.AlertDialog.Builder(L2_46.this).setTitle("提示").setMessage("是否要删除 " .. A1_40.Tag.name.Text).setPositiveButton("删除", {
            onClick = function(A0_47)
              local L1_48, L2_49, L3_50
              L1_48 = L2_46
              L2_49 = L1_48.io
              L2_49 = L2_49.open
              L3_50 = "sdcard/Lua editor/open"
              L2_49 = L2_49(L3_50)
              L3_50 = L2_49
              L2_49 = L2_49.read
              L2_49 = L2_49(L3_50, "*a")
              L3_50 = L1_48.Filepath
              L3_50 = L3_50.Text
              L3_50 = L3_50 .. "/" .. A1_40.Tag.name.Text
              if L2_49 == L3_50 then
                L1_48["提示"]("暂无法删除正在编辑的文件！")
               else
                L1_48.LuaUtil.rmDir(L1_48.File(L3_50))
                L1_48["加载"](L1_48.Filepath.Text)
                L1_48["提示"]("删除文件成功")
              end
            end
          }).setNeutralButton("取消", nil).show()
        end
      end
    }).show()
  end
  return true
end
L0_0.onItemLongClick = L1_1
L0_0 = {}
opentab = L0_0
L0_0 = io
L0_0 = L0_0.open
L1_1 = "sdcard/Lua editor/open"
L0_0 = L0_0(L1_1)
L1_1 = L0_0
L0_0 = L0_0.read
L0_0 = L0_0(L1_1, L2_2)
L1_1 = import
L1_1(L2_2)
L1_1 = _ENV["加载"]
L11_11 = L2_2()
L1_1(L2_2, L3_3, L4_4, L5_5, L6_6, L7_7, L8_8, L9_9, L10_10, L11_11, L2_2())
L1_1 = _ENV["添加路径"]
L11_11 = L3_3()
L1_1(L2_2, L3_3)
L1_1 = File
L1_1 = L1_1(L2_2)
L1_1 = L1_1.exists
L1_1 = L1_1()
if L1_1 then
  L1_1 = io
  L1_1 = L1_1.open
  L1_1 = L1_1(L2_2)
  L1_1 = L1_1.read
  L1_1 = L1_1(L2_2, L3_3)
  L2_2(L3_3)
  luapath = L0_0
end
L1_1 = io
L1_1 = L1_1.open
L1_1 = L1_1(L2_2)
L1_1 = L1_1.read
L1_1 = L1_1(L2_2, L3_3)
ase = L2_2
for L5_5, L6_6 in L2_2(L3_3) do
  L10_10 = tostring
  L11_11 = L6_6
  L10_10 = L10_10(L11_11)
  L11_11 = ")"
  L8_8(L9_9)
  break
end
L2_2.OnSelectionChangedListener = L3_3
L2_2.onScrollChange = L3_3
L2_2.onClick = L3_3
L2_2.onClick = L3_3
L2_2.onClick = L3_3
L2_2.onClick = L3_3
L2_2.onClick = L3_3
L2_2.onClick = L3_3
Sharing = L2_2
item = L2_2
_ENV["常用布局"] = L2_2
_ENV["常用控件"] = L2_2
_ENV["常用事件"] = L2_2
_ENV["布局属性"] = L2_2
_ENV["控件属性"] = L2_2
_ENV["布局模板"] = L2_2
_ENV["中文函数"] = L2_2
for L5_5 in L2_2(L3_3) do
  L6_6 = table
  L6_6 = L6_6.insert
  L11_11 = L8_8(L9_9)
  L6_6(L7_7, L8_8, L9_9, L10_10, L11_11, L8_8(L9_9))
end
for L5_5 in L2_2(L3_3) do
  L6_6 = table
  L6_6 = L6_6.insert
  L11_11 = L8_8(L9_9)
  L6_6(L7_7, L8_8, L9_9, L10_10, L11_11, L8_8(L9_9))
end
for L5_5 in L2_2(L3_3) do
  L6_6 = table
  L6_6 = L6_6.insert
  L11_11 = L8_8(L9_9)
  L6_6(L7_7, L8_8, L9_9, L10_10, L11_11, L8_8(L9_9))
end
for L5_5 in L2_2(L3_3) do
  L6_6 = table
  L6_6 = L6_6.insert
  L11_11 = L8_8(L9_9)
  L6_6(L7_7, L8_8, L9_9, L10_10, L11_11, L8_8(L9_9))
end
for L5_5 in L2_2(L3_3) do
  L6_6 = table
  L6_6 = L6_6.insert
  L11_11 = L8_8(L9_9)
  L6_6(L7_7, L8_8, L9_9, L10_10, L11_11, L8_8(L9_9))
end
for L5_5 in L2_2(L3_3) do
  L6_6 = table
  L6_6 = L6_6.insert
  L11_11 = L8_8(L9_9)
  L6_6(L7_7, L8_8, L9_9, L10_10, L11_11, L8_8(L9_9))
end
for L5_5 in L2_2(L3_3) do
  L6_6 = table
  L6_6 = L6_6.insert
  L11_11 = L8_8(L9_9)
  L6_6(L7_7, L8_8, L9_9, L10_10, L11_11, L8_8(L9_9))
end
L2_2(L3_3, L4_4)
L2_2(L3_3, L4_4)
L2_2(L3_3, L4_4)
L2_2(L3_3, L4_4)
L2_2(L3_3, L4_4)
L2_2(L3_3, L4_4)
L2_2(L3_3, L4_4)
L2_2()
L2_2(L3_3)
L2_2(L3_3)
L2_2(L3_3)
L2_2.onClick = L3_3
for L5_5 in L2_2(L3_3) do
  L6_6 = newButton
  L6_6(L7_7)
end
onStop = L2_2
onCreate = L2_2
onVersionChanged = L2_2
L3_3["打开"] = L4_4
function L5_5()
  edit.format()
end
L4_4["格式化"] = L5_5
L5_5 = {}
function L6_6()
  func.run()
end
L5_5["运行"] = L6_6
L6_6 = {}
L6_6["搜索"] = L7_7
L7_7["转到"] = L8_8
L8_8["导航"] = L9_9
function L10_10()
  func.checkerror()
end
L9_9["查错"] = L10_10
L10_10 = {}
function L11_11()
  func:luajm()
end
L10_10["编译"] = L11_11
L11_11 = {}
L11_11["日志"] = function()
  local L0_51
  L0_51 = _ENV
  L0_51.func.save()
  L0_51.activity.newActivity("LuaActivity/other/logcat")
end
localtab = L2_2
for L5_5, L6_6 in L2_2(L3_3) do
  for L10_10, L11_11 in L7_7(L8_8) do
    smailtoolbar.addView(loadlayout(func.addbar(L10_10, L11_11)))
  end
end
onResult = L2_2