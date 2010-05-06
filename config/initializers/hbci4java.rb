require 'java'
require File.join(RAILS_ROOT,'vendor/hbci4java.jar')

import 'org.kapott.hbci.manager.HBCIUtils'
import 'org.kapott.hbci.manager.HBCIUtilsInternal'
import 'org.kapott.hbci.passport.AbstractHBCIPassport'
import 'org.kapott.hbci.callback.HBCICallbackConsole'
import 'org.kapott.hbci.manager.HBCIHandler'

#TODO: Enable thread mode ?? (siehe unten)
begin
  HBCIUtils.init(nil, MyHBCICallback.new)
  puts "HBCI wurde initialisiert"
rescue
  puts "HBCI konnte ncht initialisiert werden!"
end

# Import JavaUtil::Date class for search params in hbci4java
class JavaUtil
  include_class 'java.util.Date'

  class Date
    def to_date
      Time.at(getTime / 1000).to_date
    end
  end
end


#class HBCIRunnable
#  include java.lang.Runnable
#
#  def initialize(&block)
#    @block = block
#  end
#
#  def run
#    RAILS_DEFAULT_LOGGER.info "Starte HBCI-Job"
#    @block.call
#    RAILS_DEFAULT_LOGGER.info "HBCI-Job beendet!"
#  end
#end
#
## Wrapper für HBCI-Aufrufe
#def hbci(&block)
#  target = HBCIRunnable.new(&block)
#  thread = java.lang.Thread.new($hbci_thread_group, target)
#  thread.start
#  thread.join
#end
#
## ThreadGroup mit eindeutigem Namen für jeden Rails-Thread erzeugen!
#$hbci_thread_group = java.lang.ThreadGroup.new("HBCI_#{java.lang.Thread.currentThread.getId}")
#hbci do
#  HBCIUtils.init(nil, MyHBCICallback.new)
#end