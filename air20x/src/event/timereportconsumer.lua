module(...,package.seeall)

local function print(...)
  _G.print("timereporterconsumer",...)
end

local function consume()
  print("time : "..misc.getclockstr())
end

--��Ϣ�������б�
local procer = {
  TIMEREPORT_EVENT = consume,
}
sys.regapp(procer)
