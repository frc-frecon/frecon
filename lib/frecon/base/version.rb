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

  class Version
    attr_reader :major, :minor, :patch, :prerelease

    def initialize(major:, minor:, patch:, prerelease: nil)
      @major, @minor, @patch, @prerelease = major, minor, patch, prerelease
    end

    def to_s
      format_string % [@major, @minor, @patch, @prerelease]
    end

    def prerelease?
      !!@prerelease
    end

    def release?
      !@prerelease
    end

    protected

    PRERELEASE_FORMAT_STRING = '%d.%d.%d-%s'
    RELEASE_FORMAT_STRING = '%d.%d.%d'

    def format_string
      prerelease? ? PRERELEASE_FORMAT_STRING : RELEASE_FORMAT_STRING
    end
  end

  # Public: A String representing the current version of FReCon.
  VERSION = Version.new(major: 1, minor: 5, patch: 0)

end
