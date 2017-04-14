import sbt._
import Keys._
import com.kalmanb.sbt.CtagsPlugin

object StagsPlugin extends CtagsPlugin {

  /**
   * [Optional] - Allows you to define where sources are unzipped to.
   *
   * @return the directory to store library sources.
   *         this local to the project base directory
   */
  override def ExternalSourcesDir: String = ".git/external-lib-src"

  /**
   * [Optional] - Allows you to override the function called after lib
   * sources are added. You can call shell commands such as ctags, gtags,
   * other indexers or tools. Called after ctagsAdd and ctagsRemove
   *
   * @param baseDirectory of the project if you need to access files within
   *        the project
   */
  override def updateCtags(baseDirectory: File): Unit = {
    /**
     * Default calls ctags
     * "ctags" !
     */
    "stags -o .git/tags ./".!
  }

}

