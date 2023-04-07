class SecondCompanyModel {
  String giveid; //供给单id
  String needid; //需求单id
  String personid; //公司ID
  String personid1; //从Project中传递过来的
  String name; //用户名称
  String info; //公司信息
  String tel; //公司的电话
  String address; //公司的地址
  String email; //公司的邮箱
  String company; //公司名称
  String pri1; //供货单价格，减少一次查询操作
  String pri2;
  String pri3;
  String pri4;
  String pri5;

  SecondCompanyModel(
    String giveid,
    String needid,
    String personid,
    String personid1,
    String name,
    String info,
    String tel,
    String address,
    String email,
    String company,
    String pri1,
    String pri2,
    String pri3,
    String pri4,
    String pri5,
  ) {
    this.giveid = giveid; //供给单id
    this.needid = needid; //需求单id
    this.personid = personid; //公司ID
    this.personid1 = personid1;
    this.name = name; //用户名称
    this.info = info; //公司信息
    this.tel = tel; //公司的电话
    this.address = address; //公司的地址
    this.email = email; //公司的邮箱
    this.company = company; //公司名称
    this.pri1 = pri1;
    this.pri2 = pri2;
    this.pri3 = pri3;
    this.pri4 = pri4;
    this.pri5 = pri5;

    // print(this.id);
    // print(this.personid);
    // print(this.name);
    // print(this.info);
    // print(this.tel);
    // print(this.address);
    // print(this.email);
    // print(this.company);
  }
}
