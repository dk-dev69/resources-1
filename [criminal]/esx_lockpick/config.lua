Config						= {}
Config.InfiniteLocks		= false  -- Should one lockpick last forever?
Config.LockTime			    = 30     -- In seconds, how long should lockpicking take?
Config.AlarmTime            = 120     -- Second to have the alarm activated once vehicle is lockpicked
Config.JammedHandbrakeTime  = 5     -- Взлом замка зажигания
Config.IgnoreAbort			= true   -- Remove lockpick from inventory even if user aborts lockpicking?
Config.AllowMecano			= true   -- Разрешить механикам использовать эту отмычку?
Config.NPCVehiclesLocked    = true   -- Блокирует все транспортные средства (ДОЛЖНЫ ИМЕТЬ НЕКОТОРЫЕ ВИДЫ LOCKSYSTEM ДЛЯ СОБСТВЕННОГО АВТОМОБИЛЯ) В будущем будет добавлен чек на принадлежащий автомобиль.
Config.Locale				= 'ru'   -- Change the language. Currently only en  but will add fr soon.
Config.percentage           = 40	 -- In percentage
Config.CallCops             = true   -- Set to true if you want cops to be alerted when lockpicking a vehicle no matter what the outcome is.
Config.CallCopsPercent      = 5      -- (min1) if 1 then cops will be called every time=100%, 2=50%, 3=33%, 4=25%, 5=20%.
Config.chance               = 40      -- chance of being unlocked in percentage

Config.blacklist = { -- vehicles that will always be locked when spawned naturally
  "T20",
  "police",
  "police2",
  "sheriff3",
  "sheriff2",
  "sheriff",
  "riot",
  "fbi",
  "hwaycar2",
  "hwaycar3",
  "hwaycar10",
  "hwaycar",
  "polf430",
  "policeb",
  "police7",
  "RHINO"
}

Config.job_whitelist = {
"police",
"fbi",
"militar",
"EMS"
}
