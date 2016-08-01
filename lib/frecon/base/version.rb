# lib/frecon/base/version.rb
#
# Copyright (C) 2016 Christopher Cooper, Sam Craig, Tiger Huang, Vincent Mai, Sam Mercier, and Kristofer Rye
#
# This file is part of FReCon, an API for scouting at FRC Competitions, which is
# licensed under the MIT license.  You should have received a copy of the MIT
# license with this program.  If not, please see
# <http://opensource.org/licenses/MIT>.

# Public: The FReCon API module.
module FReCon

	class Version < String; end

	# Public: A String representing the current version of FReCon.
	VERSION = Version.new('1.4.0')

end
