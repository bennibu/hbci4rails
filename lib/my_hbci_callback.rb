# Callback für HBCI-Aufrufe
class MyHBCICallback < HBCICallbackConsole
  @@status_names = {}
  constants.each { |c| @@status_names[const_get(c)] = c }

  def callback(passport, reason, msg, dataType, retData)
    passphrase, pin, tan = passport.getClientData('init')
    case reason
    when NEED_PASSPHRASE_LOAD then retData.replace(0, retData.length, passphrase)
    when NEED_PT_PIN then retData.replace(0, retData.length, pin)
    when NEED_PT_TAN then retData.replace(0, retData.length, tan)
    when NEED_CONNECTION, CLOSE_CONNECTION then nil
    else super
    end
  end

  def log(msg, level, date, trace)
    # Alle HBCI-Statusmeldungen einfach an der Konsole ausgeben
    puts msg
  end

  def status(passport, statusTag, o)
    puts @@status_names[statusTag]
  end
end