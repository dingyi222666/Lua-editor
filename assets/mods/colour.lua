
import "android.widget.TextView"
import "android.app.AlertDialog"
import "android.graphics.PorterDuff"
import "android.content.Context"
import "android.widget.CardView"
import "android.widget.SeekBar"
import "android.os.Build"
import "android.graphics.PorterDuffColorFilter"
import "android.widget.LinearLayout"


function 拖动条颜色(id,颜色)
  id.ProgressDrawable.setColorFilter(PorterDuffColorFilter(颜色,PorterDuff.Mode.SRC_ATOP))
  --修改SeekBar滑块颜色
  id.Thumb.setColorFilter(PorterDuffColorFilter(颜色,PorterDuff.Mode.SRC_ATOP))
end
--对话框按钮颜色
function 对话框按钮颜色(id,button,颜色)
  if Build.VERSION.SDK_INT >= 22 then
    import "android.graphics.PorterDuffColorFilter"
    import "android.graphics.PorterDuff"
    if button==1 then
      id.getButton(id.BUTTON_POSITIVE).setTextColor(颜色)
     elseif button==2 then
      id.getButton(id.BUTTON_NEGATIVE).setTextColor(颜色)
     elseif button==3 then
      id.getButton(id.BUTTON_NEUTRAL).setTextColor(颜色)
    end
  end
end
主色=0xff1e8ae8;
副色=0xFFd68189;
文字色=0xffffffff;
警告色=0xff60c5ba;
背景底层色=0xfff1f1f1;
背景顶层色=0xffffffff;
左侧栏项目色=0xFFa3a1a1;
对话框字体色=0xff000000;
--上面可无视

--源代码来自alua群
--小乙天修改并美化
-- 源代码确实比较丑
--😂


--把取色器封装了一下
function 颜色选择器()
  require "import"
  import "android.widget.*"
  import "android.view.*"
  import "android.graphics.PorterDuffColorFilter"
  import "android.graphics.PorterDuff"
  取色器=
  {
    LinearLayout;
    orientation="vertical";
    layout_width="fill";
    layout_height="fill";
    gravity="center";
    {
      CardView;
      id="卡片图";
      layout_margin="10dp";
      radius="40dp",
      elevation="0dp",
      layout_width="20%w";
      layout_height="20%w";
    };
    {
      TextView;
      layout_margin="0dp";
      textSize="12sp";
      id="颜色文本";
      textColor=左侧栏项目色;
    };
    {
      SeekBar;
      id="拖动一";
      layout_margin="15dp";
      layout_width="match";
      layout_height="wrap";
    };
    {
      SeekBar;
      id="拖动二";
      layout_margin="15dp";
      layout_width="match";
      layout_height="wrap";
    };
    {
      SeekBar;
      id="拖动三";
      layout_margin="15dp";
      layout_width="match";
      layout_height="wrap";
    };
    {
      SeekBar;
      id="拖动四";
      layout_margin="15dp";
      layout_width="match";
      layout_height="wrap";
    };
  };
  --对话框View
  local 取色器=loadlayout(取色器)
  拖动一.setMax(255)
  拖动二.setMax(255)
  拖动三.setMax(255)
  拖动四.setMax(255)
  拖动一.setProgress(0xff)
  拖动二.setProgress(0x1e)
  拖动三.setProgress(0x8a)
  拖动四.setProgress(0xe8)
  --监听
  拖动一.setOnSeekBarChangeListener{
    onProgressChanged=function(view, i)
      updateArgb()
    end
  }

  拖动二.setOnSeekBarChangeListener{
    onProgressChanged=function(view, i)
      updateArgb()
    end
  }

  拖动三.setOnSeekBarChangeListener{
    onProgressChanged=function(view, i)
      updateArgb()
    end
  }

  拖动四.setOnSeekBarChangeListener{
    onProgressChanged=function(view, i)
      updateArgb()
    end
  }
  --更新颜色
  function updateArgb()
    local a=拖动一.getProgress()
    local r=拖动二.getProgress()
    local g=拖动三.getProgress()
    local b=拖动四.getProgress()
    local argb_hex=(a<<24|r<<16|g<<8|b)
    颜色文本.Text=string.format("%#x", argb_hex)
    卡片图.setCardBackgroundColor(argb_hex)
  end
  --翻译进度
  argbBuild=AlertDialog.Builder(activity)
  argbBuild.setView(取色器)
  argbBuild.setTitle("选色器")
  argbBuild.setPositiveButton("选择", {
    onClick=function(view)
      argbDialog.cancel()
      local a=拖动一.getProgress()
      local r=拖动二.getProgress()
      local g=拖动三.getProgress()
      local a=拖动四.getProgress()
      b=颜色文本.Text
      b=b:match("0x(.+)")
      b="#"..b
      c=table.concat({a,r,g,q},",")
      items={颜色文本.Text,b,c}
      AlertDialog.Builder(this)      
      .setTitle("选择颜色")
      .setItems(items,{onClick=function(l,v) edit.paste(items[v+1])end})
      
      .show();
      
    end
  })
  argbBuild.setNeutralButton("复制",{onClick=function()
      local a=拖动一.getProgress()
      local r=拖动二.getProgress()
      local g=拖动三.getProgress()
      local q=拖动四.getProgress()
      local argb_hex=(a<<24|r<<16|g<<8|q)
      local argb_str=string.format("%#x", argb_hex)
      activity.getSystemService(Context.CLIPBOARD_SERVICE).setText(argb_str)
     argbDialog.cancel()
      b=argb_str
      b=b:match("0x(.+)")
      b="#"..b
      c=table.concat({a,r,g,q},",")
      items={颜色文本.Text,b,c}
      AlertDialog.Builder(this)      
      .setTitle("选择颜色")
      .setItems(items,{onClick=function(l,v)activity.getSystemService(Context.CLIPBOARD_SERVICE).setText(items[v+1])
        提示("已复制")  
          end})      
      .show();
     
     
    end})--设置否认按钮
  --实例化对话框
  argbDialog=argbBuild.create()
  argbDialog.setCanceledOnTouchOutside(false)
  function showArgbDialog()
    --展示对话框
    argbDialog.show()
    --更新颜色
    updateArgb()
  end
  showArgbDialog()
  对话框按钮颜色(argbDialog,1,副色)
  对话框按钮颜色(argbDialog,2,副色)
  对话框按钮颜色(argbDialog,3,副色)
  拖动条颜色(拖动一,0xff000000)
  拖动条颜色(拖动二,0xffff0000)
  拖动条颜色(拖动三,0xFF1DE9B6)
  拖动条颜色(拖动四,0xFF6699FF)
end



--调用颜色选择器
--颜色选择器()