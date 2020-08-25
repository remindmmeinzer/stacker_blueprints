stacker_blueprints
==================

.. image:: https://circleci.com/gh/cloudtools/stacker_blueprints.svg?style=shield
   :target: https://circleci.com/gh/cloudtools/stacker_blueprints

.. image:: https://badge.fury.io/py/stacker_blueprints.svg
   :target: https://badge.fury.io/py/stacker_blueprints

.. image:: https://empire-slack.herokuapp.com/badge.svg
   :target: https://empire-slack.herokuapp.com


An attempt at a common Blueprint library for use with `stacker <https://github.com/cloudtools/stacker>`_.

If you're new to stacker you may use `stacker_cookiecutter <https://github.com/cloudtools/stacker_cookiecutter>`_ to setup your project.

Running Tests
=============

To run tests locally, you need to be on an amd64 machine, and have the following
dependencies:

* Make (tested against GNU Make)
* Docker (tested against version ``19.03.12-ce``)

Then, you can run the whole test suite by invoking ``make``. You may find the
following recipes useful while developing:

* ``make lint``
* ``make test``
* ``make shell``

  This will provide you a shell inside the container used to run
  tests/linting/etc.
* ``make circle``

  This will run the CircleCI test suite locally. It's not a perfect emulation of
  CircleCI, but will help catch errors in your configuration.
