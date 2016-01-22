
require 'json'
require 'ratsit/person'

describe Ratsit::Person do

  person_initializer = JSON.load('{"Url":"http://www.ratsit.se/19440823-Stefan_Ingemar_Bernhard_Nyman_Lund/PcydUWTjGC7mEs7-w37hvcjsxyXsAOCWBawv5mHV5e4","ID":"PcydUWTjGC7mEs7-w37hvcjsxyXsAOCWBawv5mHV5e4","GivenName":"Stefan","FirstName":"\u003cb\u003eStefan\u003c/b\u003e Ingemar Bernhard","LastName":"Nyman","CoAddress":"","Address":"Skarpskyttevägen 30 D lgh 1102","ZipCode":"22642","City":"Lund","Age":71,"Born":null,"Gender":"icon_male.png","Married":"icon_married.png","CompanyEngagement":"icon_company.png","IdSkyddTyp":0,"IdSymbol":"icon_id_none.png","IdSecUrl":"http://www.ratsit.se/BC/PersonIdSec.aspx?ID=","IdSkyddKey":"","IgnoreSort":false}')

  it 'should create a person' do
    person = Ratsit::Person.new(person_initializer)
  end

end