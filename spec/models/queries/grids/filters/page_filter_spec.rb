#-- encoding: UTF-8

#-- copyright
# OpenProject is a project management system.
# Copyright (C) 2012-2018 the OpenProject Foundation (OPF)
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License version 3.
#
# OpenProject is a fork of ChiliProject, which is a fork of Redmine. The copyright follows:
# Copyright (C) 2006-2017 Jean-Philippe Lang
# Copyright (C) 2010-2013 the ChiliProject Team
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
#
# See docs/COPYRIGHT.rdoc for more details.
#++

require 'spec_helper'

describe Queries::Grids::Filters::PageFilter, type: :model do
  include_context 'filter tests'
  let(:values) { ['/my/page'] }
  let(:user) { FactoryBot.build_stubbed(:user) }
  let(:model) { Grid }

  before do
    login_as(user)
  end

  it_behaves_like 'basic query filter' do
    let(:class_key) { :page }
    let(:type) { :string }
    let(:model) { Grid.where(user_id: user.id) }
    let(:values) { ['/my/page'] }

    describe '#allowed_values' do
      it 'is /my/page' do
        expect(instance.allowed_values)
          .to match_array values
      end
    end
  end

  describe '#scope' do
    context 'for "="' do
      let(:operator) { '=' }

      context 'for /my/page do' do
        it 'is the same as handwriting the query' do
          expected = model.where("grids.type IN ('MyPageGrid')")

          expect(instance.scope.to_sql).to eql expected.to_sql
        end
      end
    end
  end
end