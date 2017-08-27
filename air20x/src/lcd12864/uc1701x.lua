module(...,package.seeall)

function init()
  local para =
  {
    width = 128,
    height = 65,
    bpp = 1,
    --xoffset = 32,
    --yoffset = 64,
    bus = disp.BUS_SPI,
    hwfillcolor = 0xFFFF,
    pinrst = pio.P0_2,
    pinrs = pio.P0_12,
    initcmd =
    {
      0xE2, --soft reset
      0x2F, --ѡ���ڲ���ѹ��Ӧ����ģʽ ͨ���� 0x2C,0x2E,0x2F ���� ָ�˳�������д����ʾ���δ��ڲ���ѹ����ѹ������·����ѹ��������Ҳ���Ե���д0x2F��һ���Դ������ֵ�·
      0x23, --ѡ���ڲ����������Rb/Ra��:�������Ϊ�ֵ��Աȶ�ֵ�������÷�ΧΪ��0x20��0x27�� ��ֵԽ��Աȶ�ԽŨ��ԽСԽ��
      0x81, --�����ڲ�����΢�����������Ϊ΢���Աȶ�ֵ��������ָ���������ʹ�á�����һ��ָ��0x81�ǲ��ĵģ�����һ��ָ������÷�ΧΪ��0x00��0x3F,��ֵԽ��Աȶ�ԽŨ��ԽСԽ��
      0xA2, --����ƫѹ�ȣ�  0XA2��BIAS=1/9 (����) 0XA3��BIAS=1/7 
      0xC8, --��ɨ��˳��ѡ��  0XC0:��ͨɨ��˳�򣺴��ϵ��� 0XC8:��תɨ��˳�򣺴��µ���
      0xA0, --��ʾ�е�ַ������  0xA0�����棺�е�ַ�����ң� 0xA1����ת���е�ַ���ҵ���
      -- 0xA7, --��ʾ����/����: 0xA6�����棺���� 0xA7������ 
      -- 0x2E,
      0x40, --������ʾ�洢������ʾ��ʼ��,������ֵΪ0X40~0X7F,�ֱ�����0��63�У���Ը�Һ����һ������Ϊ0x40
      0xAF, --��ʾ��/��: 0XAE:�أ�0XAF����
    },
    sleepcmd = {
      0xAE,
    },
    wakecmd = {
      0xAF,
    }
  }
  print("lcd init")
  disp.init(para)
  disp.clear()
end

local Y_OFFSET = 32;
local function offsetcalculate(x,y)
  y = y < 32 and (y + 32) or (y - 32)
  return x,y
end

function clear()
  disp.clear()
end

function update()
  disp.update()
end

function puttext(txt,x,y)
  x,y = offsetcalculate(x,y)
  disp.puttext(txt,x,y)
end

--[[
  fname       image name
  x           start left
  y           start top
  w           image width [optional]
  h           image height[optional] 
]]
function putimage(fname,x,y,w,h)
  x,y = offsetcalculate(x,y)
  disp.putimage(fname,x,y)
  --TODO
  --disp.putimage(fname,0,32,-1,0,0,127,31)
  --disp.putimage(fname,0,0,-1,0,32,127,63)
end

--[[
  color  black/white
  black   0x0000
  white   0xffff
]]
function setcolor(color)
  disp.setcolor(color)
end

--[[
  draw rectangle 
  maybe we could use this to clear screen
]]
function drawrect(left, top, right, bottom, color)
  if left > right then
    left,right = right,left
  end
  
  if top > bottom then
    top, bottom = bottom, top
  end
  
  if top < 32 and bottom > 32 then
    disp.drawrect(left, 32 + top, right, 64, color)  
    
    local lowpart = bottom - 31 
    disp.drawrect(left, 0, right, lowpart, color)  
  else
    top = top <= 32 and (top + 32) or (top - 32)
    bottom = bottom <= 32 and (bottom + 32) or (bottom - 32)
    disp.drawrect(left, top, right, bottom, color)  
  end
end

---------------------------------
pmd.ldoset(6,pmd.LDO_VMMC)
