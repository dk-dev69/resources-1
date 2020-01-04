Config = {}
Config.UpdateFrequency = 300 -- seconds interval between removing values 
Config.Notifications = true -- notification when skill is added

Config.Skills = {
    ["Выносливость"] = {
        ["Current"] = 20, -- Default value 
        ["RemoveAmount"] = -0.1, -- % to remove when updating,
        ["Stat"] = "MP0_STAMINA" -- GTA stat hashname
    },

    ["Сила"] = {
        ["Current"] = 10,
        ["RemoveAmount"] = -0.1,
        ["Stat"] = "MP0_STRENGTH"
    },

    ["Объем легких"] = {
        ["Current"] = 0,
        ["RemoveAmount"] = -0.1,
        ["Stat"] = "MP0_LUNG_CAPACITY"
    },

    ["Стрельба"] = {
        ["Current"] = 0,
        ["RemoveAmount"] = -0.1,
        ["Stat"] = "MP0_SHOOTING_ABILITY"
    },

    ["Driving"] = {
        ["Current"] = 0,
        ["RemoveAmount"] = -0.1,
        ["Stat"] = "MP0_DRIVING_ABILITY"
    },

    ["Полет"] = {
        ["Current"] = 5,
        ["RemoveAmount"] = -0.1,
        ["Stat"] = "MP0_FLYING_ABILITY"
    },

    ["Wheelie"] = {
        ["Current"] = 0,
        ["RemoveAmount"] = -0.1,
        ["Stat"] = "MP0_WHEELIE_ABILITY"
    }
}
