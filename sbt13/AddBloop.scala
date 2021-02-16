package com.mlbam.adtech.sbt

import org.scalafmt.sbt.ScalafmtPlugin, ScalafmtPlugin.autoImport._
import sbt.Keys._
import sbt._
import scalafix.sbt.ScalafixPlugin, ScalafixPlugin.autoImport._
import bloop.integrations.sbt.BloopDefaults

object LocalPlugin extends AutoPlugin {
  override def requires = sbt.plugins.JvmPlugin
  override def trigger = allRequirements

  // import net.cakesolutions.CakeBuildKeys._
  import Scopes._
  override def projectSettings =
    inConfig(FunctionalTest)(BloopDefaults.configSettings) ++
      inConfig(ScalaMeter)(BloopDefaults.configSettings)
}
