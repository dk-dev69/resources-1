Config = {}
Config.Locale = "ru"
--You can add here buttons like inventory menu button. When player click this button, then action will be cancel.
Config.cancel_buttons = {289, 170, 168, 56}

options =
{
  ['seed_weed'] = {
        object = 'prop_weed_01',
        end_object = 'prop_weed_02',
        fail_msg = 'К сожалению, ваше растение засохло!',
        success_msg = 'Поздравляю, вы сделали коллекцию растений!',
        start_msg = 'Я начинаю выращивать растения.',
        success_item = 'weed',
        cops = 0,
        first_step = 2.35,
        steps = 7,
        cords = {
          {x = -427.05, y = 1575.25, z = 357, distance = 20.25},
          {x = 2213.05, y = 5576.25, z = 53, distance = 10.25},
          {x = 1198.05, y = -215.25, z = 55, distance = 20.25},
          {x = 706.05, y = 1269.25, z = 358, distance = 10.25},
        },
        animations_start = {
          {lib = 'amb@world_human_gardener_plant@male@enter', anim = 'enter', timeout = '2500'},
          {lib = 'amb@world_human_gardener_plant@male@idle_a', anim = 'idle_a', timeout = '2500'},
        },
        animations_end = {
          {lib = 'amb@world_human_gardener_plant@male@exit', anim ='exit', timeout = '2500'},
          {lib = 'amb@world_human_cop_idles@male@idle_a', anim ='idle_a', timeout = '2500'},
        },
        animations_step = {
          {lib = 'amb@world_human_gardener_plant@male@enter', anim = 'enter', timeout = '2500'},
          {lib = 'amb@world_human_gardener_plant@male@idle_a', anim ='idle_a', timeout = '18500'},
          {lib = 'amb@world_human_gardener_plant@male@exit', anim ='exit', timeout = '2500'},
        },
        grow = {
          2.24, 1.95, 1.65, 1.45, 1.20, 1.00
        },
        questions = {
            {
                title = 'Вы видите, что ваше растение прорастает, что вы делаете?',
                steps = {
                    {label = 'Я поливаю растение', value = 1},
                    {label = 'Я оплодотворяю почву', value = 2},
                    {label = 'Ожидаю', value = 3}
                },
                correct = 1
            },
            {
                title = 'Это растение в ваших желтых точках оказалось, что ты делаешь?',
                steps = {
                    {label = 'Podlewam Roślinę', value = 1},
                    {label = 'Nawożę Roslinę', value = 2},
                    {label = 'Ожидаю', value = 3}
                },
                correct = 2
            },
            {
                title = 'Голубая пыль появилась на листьях вашего растения, что вы делаете?',
                steps = {
                    {label = 'Zrywam poszczególne liście', value = 1},
                    {label = 'Posypuje liście nawozem', value = 2},
                    {label = 'Ожидаю', value = 3}
                },
                correct = 3
            },
            {
                title = 'U twojej roślinki pojawiły się pierwsze topy, co robisz?',
                steps = {
                    {label = 'Podlewam Roślinę', value = 1},
                    {label = 'Zrywam je od razu', value = 2},
                    {label = 'Nawożę roślinę', value = 3}
                },
                correct = 1
            },
            {
                title = 'Po podlaniu twojej roślinki, zaczeły się pojawiać dziwne liście, co robisz?',
                steps = {
                    {label = 'Podlewam Roślinę', value = 1},
                    {label = 'Nawożę Roslinę', value = 2},
                    {label = 'Czekam', value = 3}
                },
                correct = 2
            },
            {
                title = 'Twoja roślinka jest już prawie gotowa do ścięcia, co robisz?',
                steps = {
                    {label = 'Podlewam Roślinę', value = 1},
                    {label = 'Nawożę Roslinę', value = 2},
                    {label = 'Czekam', value = 3}
                },
                correct = 1
            },
            {
                title = 'Twoja roślinka jest gotowa do zbiorów, co robisz?',
                steps = {
                    {label = 'Zbierz przy użyciu nożyczek', value = 1, min = 5, max = 25},
                    {label = 'Zbierz rękoma', value = 1, min = 10, max = 15},
                    {label = 'Zetnij sekatorem', value = 1, min = 2, max = 40}
                },
                correct = 1
            },
        },
      },
}
