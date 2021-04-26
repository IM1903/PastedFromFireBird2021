local fakeRadioHeader = 'playerchatwheel . "'
local fakeRadioMode
local realRadioContent
local fakeRadioUser
local itemType
local itemGrade
local itemName
local names = {}
local old_size = #names
local localPlayer
local enabled

local useIt = ui.new_checkbox('lua', 'B', 'Fake radio/ message/ unbox meme')
local fRadioModeSelector =
    ui.new_combobox('lua', 'B', 'What you wanna do?', '-', 'Fake message', 'Fake unbox', 'Fake ban', 'Custom radio')
local rRadioSelector =
    ui.new_combobox('lua', 'B', 'Radio used to disguise', 'Cheers!', 'Sorry!', 'Thanks!', 'Negative.', 'Custom')
local rCustomRadioLabel = ui.new_label('lua', 'B', 'Custom radio')
local rCustomRadioInput = ui.new_textbox('lua', 'B', 'Custom radio content')
local fRadioUsrSelector = ui.new_combobox('lua', 'B', 'Who will *say* this?', 'Self', unpack(names))
local itemTypeSelector = ui.new_combobox('lua', 'B', 'Ways to Obtain?', 'Unbox', 'Transaction', 'Gift')
local itemGradeSelector =
    ui.new_combobox(
    'lua',
    'B',
    'Item grade?',
    'Consumer',
    'Industrial',
    'Mil-spec',
    'Classified',
    'Extraordinary',
    'Contraband'
)
local itemNameLabel = ui.new_label('lua', 'B', 'Item name?')
local customMsgLabel = ui.new_label('lua', 'B', 'Message content')
local itemNameInput = ui.new_textbox('lua', 'B', 'Item name')

local proceedButton =
    ui.new_button(
    'lua',
    'B',
    'Lets Go',
    function()
        if (usingMode == 'Fake unbox') then
            realRadioContent = ui.get(rRadioSelector)
            fakeRadioUser = ui.get(fRadioUsrSelector)
            itemType = ui.get(itemTypeSelector)
            itemGrade = ui.get(itemGradeSelector)
            itemName = ui.get(itemNameInput)

            if (fakeRadioUser == 'Self') then
                localPlayer = entity.get_local_player()
                local localName = entity.get_player_name(localPlayer)
                fakeRadioUser = localName
            else
                fakeRadioUser = fakeRadioUser
            end

            if (itemType == 'Unbox') then
                itemType = ' has opened a container and found: '
            elseif (itemType == 'Transaction') then
                itemType = ' has received in trade: '
            elseif (itemType == 'Gift') then
                itemType = ' has accepted a gift: '
            end

            if (itemGrade == 'Consumer') then
                itemGrade = ''
            elseif (itemGrade == 'Industrial') then
                itemGrade = ''
            elseif (itemGrade == 'Mil-spec') then
                itemGrade = ''
            elseif (itemGrade == 'Classified') then
                itemGrade = ''
            elseif (itemGrade == 'Extraordinary') then
                itemGrade = ''
            elseif (itemGrade == 'Contraband') then
                itemGrade = ''
            end
            client.exec(
                fakeRadioHeader,
                realRadioContent .. ' ' .. fakeRadioUser .. '' .. itemType .. itemGrade .. itemName .. '"'
            )
        elseif (usingMode == 'Fake ban') then
            realRadioContent = ui.get(rRadioSelector)
            fakeRadioUser = ui.get(fRadioUsrSelector)
            itemType = ui.get(itemTypeSelector)
            itemName = ui.get(itemNameInput)

            if (fakeRadioUser == 'Self') then
                localPlayer = entity.get_local_player()
                local localName = entity.get_player_name(localPlayer)
                fakeRadioUser = localName
            else
                fakeRadioUser = fakeRadioUser
            end

            if (itemType == 'Cooldown30Min') then
                client.exec(
                    fakeRadioHeader,
                    realRadioContent ..
                        ' ' .. '' .. fakeRadioUser .. ' abandoned the match and received a 30 minutes cooldown.'
                )
            elseif (itemType == 'Cooldown24Hrs') then
                client.exec(
                    fakeRadioHeader,
                    realRadioContent ..
                        ' ' .. '' .. fakeRadioUser .. ' abandoned the match and received a 24 hours cooldown.'
                )
            elseif (itemType == 'Cooldown7Day') then
                client.exec(
                    fakeRadioHeader,
                    realRadioContent ..
                        ' ' .. '' .. fakeRadioUser .. ' abandoned the match and received a 7 days cooldown.'
                )
            elseif (itemType == 'VACban') then
                client.exec(
                    fakeRadioHeader,
                    realRadioContent ..
                        ' ' ..
                            '' .. fakeRadioUser .. ' has been permanently banned from official CS:GO servers.' .. '"'
                )
            end
        elseif (usingMode == 'Fake message') then
            fakeRadioMode = ui.get(fRadioModeSelector)
            realRadioContent = ui.get(rRadioSelector)
            fakeRadioUser = ui.get(fRadioUsrSelector)
            itemName = ui.get(itemNameInput)

            if (fakeRadioUser == 'Self') then
                localPlayer = entity.get_local_player()
                local localName = entity.get_player_name(localPlayer)
                if entity.is_alive(localPlayer) then
                    fakeRadioUser = localName
                else
                    fakeRadioUser = '*DEAD* ' .. localName
                end
            else
                fakeRadioUser = fakeRadioUser
                for i = globals.maxplayers(), 1, -1 do
                    i = math.floor(i)
                    local name = entity.get_player_name(i)
                    if (name ~= 'unknown' and i ~= localPlayer) then
                        if (fakeRadioUser == name and entity.is_alive(i)) then
                            fakeRadioUser = fakeRadioUser
                        end
                        if (fakeRadioUser == name and not entity.is_alive(i)) then
                            fakeRadioUser = '*DEAD* ' .. fakeRadioUser
                        end
                    end
                end
            end
            client.exec(fakeRadioHeader, realRadioContent .. ' ' .. fakeRadioUser .. ' : ' .. itemName .. '"')
        elseif (usingMode == 'Custom radio') then
            local msgColor = ui.get(rRadioSelector)
            if (msgColor == 'Normal') then
                msgColor = ''
            elseif (msgColor == 'White') then
                msgColor = ''
            elseif (msgColor == 'Grey') then
                msgColor = ''
            elseif (msgColor == 'Green') then
                msgColor = ''
            elseif (msgColor == 'Chartreuse Green') then
                msgColor = ''
            elseif (msgColor == 'Spring Green') then
                msgColor = ''
            elseif (msgColor == 'Light blue') then
                msgColor = ''
            elseif (msgColor == 'Darker blue') then
                msgColor = ''
            elseif (msgColor == 'Pinkish purple') then
                msgColor = ''
            elseif (msgColor == 'Red') then
                msgColor = ''
            elseif (msgColor == 'Crimson') then
                msgColor = ''
            elseif (msgColor == 'Gold') then
                msgColor = ''
            end
            itemName = ui.get(itemNameInput)
            client.exec(fakeRadioHeader, msgColor .. itemName .. '"')
        end
    end
)

local function updateNames()
    local ret = {}
    localPlayer = entity.get_local_player()
    for i = globals.maxplayers(), 1, -1 do
        i = math.floor(i)
        local name = entity.get_player_name(i)
        if (name ~= 'unknown' and i ~= localPlayer) then
            table.insert(ret, name)
        end
    end
    names = ret
end

local function updateNameList()
    if old_size ~= #names then
        ui.set_visible(fRadioUsrSelector, false)
        if (ui.get(fRadioModeSelector) == 'Fake message') then
            fRadioUsrSelector = ui.new_combobox('lua', 'B', 'Who will *say* this?', 'Self', unpack(names))
        elseif (ui.get(fRadioModeSelector) == 'Fake unbox') then
            fRadioUsrSelector = ui.new_combobox('lua', 'B', 'Who will have this?', 'Self', unpack(names))
        elseif (ui.get(fRadioModeSelector) == 'Fake ban') then
            fRadioUsrSelector = ui.new_combobox('lua', 'B', 'Who get "banned"?', 'Self', unpack(names))
        end
        old_size = #names
        enabled = ui.get(useIt)
        if not enabled then
            ui.set_visible(fRadioUsrSelector, false)
            return
        else
            return
        end
    else
        return
    end
end

local refreshNameList =
    ui.new_button(
    'lua',
    'B',
    'Refresh name list',
    function()
        updateNames()
        updateNameList()
    end
)

local function refreshUI()
    ui.set_visible(fRadioModeSelector, false)
    ui.set_visible(rRadioSelector, false)
    ui.set_visible(rCustomRadioLabel, false)
    ui.set_visible(rCustomRadioInput, false)
    ui.set_visible(fRadioUsrSelector, false)
    ui.set_visible(itemTypeSelector, false)
    ui.set_visible(itemGradeSelector, false)
    ui.set_visible(itemNameLabel, false)
    ui.set_visible(customMsgLabel, false)
    ui.set_visible(itemNameInput, false)
    ui.set_visible(refreshNameList, false)
    ui.set_visible(proceedButton, false)
end

local function mode_FakeBan()
    refreshUI()
    ui.set_visible(fRadioModeSelector, true)
    rRadioSelector =
        ui.new_combobox('lua', 'B', 'Radio used to disguise', 'Cheers!', 'Sorry!', 'Thanks!', 'Negative.', 'Roger.')
    fRadioUsrSelector = ui.new_combobox('lua', 'B', 'Who get "banned"?', 'Self', unpack(names))
    itemTypeSelector =
        ui.new_combobox('lua', 'B', 'Ban type', 'Cooldown30Min', 'Cooldown24Hrs', 'Cooldown7Day', 'VACban')
    ui.set_visible(refreshNameList, true)
    ui.set_visible(proceedButton, true)
end

local function mode_FakeUnbox()
    refreshUI()
    ui.set_visible(fRadioModeSelector, true)
    rRadioSelector =
        ui.new_combobox('lua', 'B', 'Radio used to disguise', 'Cheers!', 'Sorry!', 'Thanks!', 'Negative.', 'Roger.')
    fRadioUsrSelector = ui.new_combobox('lua', 'B', 'Who will have this?', 'Self', unpack(names))
    itemTypeSelector = ui.new_combobox('lua', 'B', 'Ways to Obtain?', 'Unbox', 'Transaction', 'Gift')
    itemGradeSelector =
        ui.new_combobox(
        'lua',
        'B',
        'Item grade?',
        'Consumer',
        'Industrial',
        'Mil-spec',
        'Classified',
        'Extraordinary',
        'Contraband'
    )
    itemNameLabel = ui.new_label('lua', 'B', 'Item name?')
    itemNameInput = ui.new_textbox('lua', 'B', 'Item name')
    ui.set_visible(refreshNameList, true)
    ui.set_visible(proceedButton, true)
end

local function mode_FakeMessage()
    refreshUI()
    ui.set_visible(fRadioModeSelector, true)
    rRadioSelector =
        ui.new_combobox('lua', 'B', 'Radio used to disguise', 'Cheers!', 'Sorry!', 'Thanks!', 'Negative.', 'Roger.')
    ui.set_visible(fRadioUsrSelector, true)
    ui.set_visible(customMsgLabel, true)
    ui.set_visible(itemNameInput, true)
    ui.set_visible(refreshNameList, true)
    ui.set_visible(proceedButton, true)
end

local function mode_CustomRadio()
    refreshUI()
    ui.set_visible(fRadioModeSelector, true)
    customMsgLabel = ui.new_label('lua', 'B', 'Advanced Radio:')
    itemNameInput = ui.new_textbox('lua', 'B', 'Radio content')
    rRadioSelector =
        ui.new_combobox(
        'lua',
        'B',
        'Message color',
        'Normal',
        'White',
        'Grey',
        'Green',
        'Chartreuse Green',
        'Spring Green',
        'Light blue',
        'Darker blue',
        'Pinkish purple',
        'Red',
        'Crimson',
        'Gold'
    )
    ui.set_visible(proceedButton, enabled)
end

local function handleMenu(...)
    enabled = ui.get(useIt)
    usingMode = ui.get(fRadioModeSelector)
    if enabled then
        ui.set_visible(fRadioModeSelector, enabled)
        if (usingMode == 'Fake unbox') then
            mode_FakeUnbox()
        elseif (usingMode == 'Fake ban') then
            mode_FakeBan()
        elseif (usingMode == 'Fake message') then
            mode_FakeMessage()
        elseif (usingMode == 'Custom radio') then
            mode_CustomRadio()
        elseif (usingMode == '-') then
            refreshUI()
            ui.set_visible(fRadioModeSelector, true)
        end
    elseif not enabled then
        refreshUI()
    end
end

handleMenu()

ui.set_callback(useIt, handleMenu)
ui.set_callback(fRadioModeSelector, handleMenu)
ui.set_callback(rRadioSelector, handleMenu)
