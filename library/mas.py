#!/usr/bin/python -tt

# -*- coding: utf-8 -*-

# AWAITING MERGE
# https://github.com/ansible/ansible/pull/19768

# (c) 2017, Michael Heap
# Written by Michael Heap <m@michaelheap.com>
# Based on yum module written by Seth Vidal <skvidal at fedoraproject.org>
#
# This module is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This software is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this software.  If not, see <http://www.gnu.org/licenses/>.

ANSIBLE_METADATA = {'status': ['preview'],
                    'supported_by': 'community',
                    'metadata_version': '1.0'}

DOCUMENTATION = '''
module: mas
author:
    - "Michael Heap (@mheap)"
version_added: "2.4"
short_description: Manage applications via the Mac App Store
description:
    - Manage applications via the Mac App Store
options:
    id:
        description:
        - The ID of the package you want to install
        - This can be found by running C(mas search APP_NAME) on your machine
        required: true
    state:
        description:
          - C(present) will make sure the package is installed.
        required: false
        choices: [ present ]
        default: "present"
'''

EXAMPLES = '''
- name: Install Keynote
  mas:
    id: 409183694
    state: present

- name: Install Divvy
  mas:
    id: 413857545
    state: present
'''

RETURN = '''
id:
  description: the ID of the package installed
  returned: success
  type: string
  sample: 409183694
'''

from ansible.module_utils.basic import AnsibleModule
import os


class Mas(object):

    def __init__(self, module):
        self.module = module
        self.params = module.params

        # Populate caches
        self.mas_path = self.find_mas()
        self.check_logged_in()
        self._installed = self.cache_installed()

    def cache_installed(self):
        rc, raw_list, err = self.run(["list"])
        rows = raw_list.split("\n")
        installed = {}
        for r in rows:
            r = r.split(" ", 1)
            if len(r) == 2:
                installed[r[1]] = r[0]
        return installed

    def find_mas(self):
        mas_path = False

        path = self.params['mas_path']
        if path is None:
            path = 'mas'

        # They may have given us a direct path
        if path[0] == '/':
            possible_paths = [path]
        else:
            possible_paths = [(pre + "/" + path)
                              for pre in os.environ['PATH'].split(":")]

        found_mas = False
        for p in possible_paths:
            if os.access(p, os.X_OK):
                mas_path = p
                break

        if mas_path is None:
            raise IOError("Could not find the MAS binary")

        return mas_path

    def check_logged_in(self):
        rc, out, err = self.run(["account"])
        if out.rstrip() == 'Not signed in':
            raise Exception("You must sign in to the Mac App Store")

        return True

    def run(self, cmd):
        cmd.insert(0, self.mas_path)
        return self.module.run_command(cmd, False)

    def install(self, id, dry_run):
        if not dry_run:
            rc, out, err = self.run(["install", id])
            if rc != 0:
                return "Error installing '{}': {}".format(id, err.rstrip())
        return None

    def is_installed(self, id):
        return id in self._installed.values()


def main():
    module = AnsibleModule(
        argument_spec=dict(
            state=dict(default='present', choices=['present']),
            id=dict(required=False),
            mas_path=dict(default=None)
        )
    )

    state = module.params['state']

    # Is `mas` installed?
    try:
        mas = Mas(module)
    except IOError:
        e = get_exception()
        module.fail_json(msg=e.message)
    except Exception:
        e = get_exception()
        module.fail_json(msg=e.message)

    args = {
        "changed": False,
        'id': module.params['id']
    }

    if state == 'present':
        if not mas.is_installed(module.params['id']):
            err = mas.install(module.params['id'], module.check_mode)
            if err is not None:
                module.fail_json(msg=err)
            else:
                args['changed'] = True
    else:
        module.fail_json(msg="State must be one of 'present'")

    module.exit_json(**args)

if __name__ == '__main__':
    main()
