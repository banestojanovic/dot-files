-- lua/plugins/rose-pine.lua
return {
	"rose-pine/neovim",
	name = "rose-pine",
	opts = {
		dark_variant = "moon",
	},
	config = function(plugin, opts)
		require("rose-pine").setup(opts)
	end
}
