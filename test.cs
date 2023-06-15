
// implement yourself
class Gun{


    public void AddPart(GunPart part)
    {

    }

}


// internal resources
class GunPart : Resource{
    [Export]
    public int cost =0;

    // put every single gun part related thing here

}


class GunDef : Resource{
    public Dictionary<String,List<GunPart>> parts = new();
}
// end of resources



// make this an autoload
class GunCreator : Node{
    [Export]
    
    // is just so you can get gundefs from other places
    private List<GunDef> guns;
    
    public void getGunfromId(int id)
    {
        return guns[id]
    }



    public Gun generateGun(int money,GunDef gunToCreate){

        Gun shinynewgun = new();

        foreach (String part_name in gunToCreate.parts.keys())
        {

            current_part_list = gunToCreate.parts[part_name];
            // make sure EVERY gun def has a base part with 0 cost or else it freezes lol
            while (true)
            {
                // don't actually have the C# godot stuff on my computer rn, so not generating rng
                int random_number = 3;
                GunPart part_selected = current_part_list[random_number];

                if (part_selected.cost <= money)
                {
                    shinynewgun.AddPart(part_selected);
                    money -= part_selected.cost;

                }

                





            }


        }

        return shinynewgun

    }

}