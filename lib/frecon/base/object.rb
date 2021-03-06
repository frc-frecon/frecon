# lib/frecon/base/object.rb
#
# Copyright (C) 2014 Christopher Cooper, Sam Craig, Tiger Huang, Vincent Mai, Sam Mercier, and Kristofer Rye
#
# This file is part of FReCon, an API for scouting at FRC Competitions, which is
# licensed under the MIT license.  You should have received a copy of the MIT
# license with this program.  If not, please see
# <http://opensource.org/licenses/MIT>.

class Object

	# Alias #is_a? to #is_an?. This allows us to write more
	# proper-English-y code.
	alias_method :is_an?, :is_a?

end
