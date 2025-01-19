local uci = require("simple-uci").cursor()

local f = Form(translate("VPN"))

local s = f:section(Section, nil, translate(
	'You can set some VPN Settings. '
))

local preference = s:option(ListValue, "preference", translate("Preference"))
preference.default = uci:get('wireguard', 'mesh_vpn', 'preference') or "auto"

local preference_list = uci:get_list('wireguard', 'mesh_vpn', 'preference_list')

for _, preference_list_value in ipairs(preference_list) do
	preference:value(preference_list_value)
end


function f:write()
	
	uci:set("wireguard", "mesh_vpn", "preference", preference.data)

	uci:commit('wireguard')

end

return f