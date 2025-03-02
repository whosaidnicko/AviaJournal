
import SwiftUI

struct PrivacyPolicyView: View {
    var body: some View {
        VStack(spacing: 24.flexible()){
            LinkHeaderView(title: "PRIVACY POLICY")
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: 12.flexible()){
                    Text(privacyText)
                        .font(.inter(14.flexible()))
                        .foregroundStyle(Color.white)
                        .lineSpacing(1)
                }
                .padding(.vertical, 8.flexible())
            }
        }
        .padding(.horizontal, 24.flexible())
        .appBackground()
    }
    
    let privacyText: String = """
    Lorem ipsum dolor sit amet consectetur. Elementum id enim odio turpis curabitur imperdiet placerat. Quis egestas mauris quis ultrices imperdiet in nisl arcu. Quis vivamus lectus magna ut vel lectus. Donec vitae aliquet etiam est iaculis imperdiet volutpat purus. Urna commodo tristique nulla sit nec sed vitae vitae. Eu pulvinar et eu vel id phasellus nisl mollis euismod. Maecenas auctor convallis quis aliquam. Non consequat libero sed lorem diam consectetur. Tristique nunc eget lectus in. Tincidunt tellus volutpat a eros sit arcu. Quam eu adipiscing sed in et. Urna consectetur erat dignissim nunc viverra ultrices varius.
    
    Quis ut integer dolor cursus. Nibh mauris felis accumsan feugiat fringilla nunc erat accumsan. Urna augue auctor laoreet enim tincidunt morbi. Quisque maecenas risus integer imperdiet. Gravida malesuada commodo eu aliquet scelerisque ut amet morbi id. Et iaculis dignissim venenatis amet viverra tincidunt. Pretium tristique fringilla nunc risus congue dui nulla massa sed.
    
    Non nec a et convallis lectus. Vitae dis integer mi viverra a neque iaculis volutpat. Odio sed hac est senectus eleifend at scelerisque. Mattis elementum lectus velit scelerisque. Quis pulvinar accumsan non ullamcorper pellentesque pretium dui imperdiet sapien.
    
    Id nullam ipsum neque enim volutpat diam egestas vestibulum. Sed imperdiet blandit lectus amet nunc augue et. Scelerisque pellentesque purus turpis mauris lacus semper risus bibendum. In proin nisl et leo morbi. Pretium elit non fames blandit. Blandit odio aenean nec orci est est ut dolor. Euismod ullamcorper faucibus gravida ultricies volutpat. Gravida vitae dolor proin quam sem quis nibh quam. Nec sollicitudin cum mattis viverra. Adipiscing natoque quam tellus nibh.
    
    Vulputate risus nullam duis risus facilisi. Urna quis volutpat vitae duis. Arcu sagittis cursus nisi faucibus ut fringilla neque tempor morbi. Diam ornare turpis enim eu dictum aenean a.
    Eget vulputate tortor tincidunt faucibus viverra. Sit in metus nullam viverra et ac. Mattis varius quis lectus lacus proin et eu morbi. Nunc mi amet tellus dis dui donec amet mi nunc. Nullam id a sollicitudin in sollicitudin mollis. Tortor purus amet magna lacus egestas ac ut nunc dui. Sed tellus euismod ac ac a. Ac sed posuere cursus eget dui augue sit arcu. Vitae orci quam tellus libero quam egestas.
    """
}

#Preview {
    PrivacyPolicyView()
}
