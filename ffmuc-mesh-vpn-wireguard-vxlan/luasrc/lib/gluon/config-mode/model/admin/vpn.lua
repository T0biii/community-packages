local uci = require("simple-uci").cursor()

local f = Form(translate("VPN"))

local s = f:section(Section, nil, translate(
	'You can set some VPN Settings. '
))

local enabled = s:option(Flag, "enabled", translate("Enabled"))
enabled.default = uci:get('wireguard', 'mesh_vpn') and uci:get_bool('gluon', 'mesh_vpn', 'enabled')

local loadbalancing = s:option(Flag, "loadbalancing", translate("Loadbalancing"))
loadbalancing.default = uci:get('wireguard', 'mesh_vpn') and uci:get('gluon', 'mesh_vpn', 'loadbalancing')

function f:write()
	local vpn_enabled = false
	if enabled.data then
		vpn_enabled = true
	end

    local vpn_loadbalancing
    if loadbalancing.data then
        vpn_loadbalancing = true
    else
        vpn_loadbalancing = false
    end

	uci:section('wireguard', 'mesh_vpn', 'mesh_vpn', {
		enabled = vpn_enabled,
        loadbalancing = vpn_loadbalancing,
	})

	uci:commit('wireguard')
end

return f