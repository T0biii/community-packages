local uci = require("simple-uci").cursor()

local f = Form(translate("VPN"))

local s = f:section(Section, nil, translate(
	'You can set some VPN Settings. '
))

local preference = s:option(ListValue, "preference", translate("Preference"))
preference.default = uci:get('wireguard', 'mesh_vpn', 'preference') or "auto"

preference:value('auto', translate('automatic'))
preference:value('muc', translate('Munich'))
preference:value('vie', translate('Vienna'))

function f:write()
	
	uci:set("wireguard", "mesh_vpn", "preference", preference.data)

	uci:commit('wireguard')

end

return f