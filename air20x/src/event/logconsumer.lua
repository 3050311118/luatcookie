module(...,package.seeall)

local function print(...)
  _G.print("logconsumer",...)
end

local function consume()
  print("consumed by log consumer")
end

--��Ϣ�������б�
local procer = {
  LOG_EVENT = consume,
}
sys.regapp(procer)

