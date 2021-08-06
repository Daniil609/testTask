
import SwiftUI

struct RowContent : View {
    let text : String
    let index : Int
    @Binding var indices : [Int]
    @State var offset = CGSize.zero
    @State var offsetY : CGFloat = 0
    @State var scale : CGFloat = 0.5
    
    var body : some View {
        GeometryReader { geo in
            HStack (spacing : 0){
                
                Text(text)
                    .padding()
                    .frame(width : geo.size.width, alignment: .leading)
                
                ZStack {
                    Image(systemName: "trash")
                        .font(.system(size: 20))
                        .scaleEffect(scale)
                }
                .frame(width: 60, height: geo.size.height)
                .background(Color.purple.opacity(0.15))
                .onTapGesture {
                    indices.append(index)
                }
                ZStack {
                Image(systemName: "app.gift.fill")
                    .font(.system(size: 20))
                    .overlay(
                        Image(systemName: "heart.fill")
                            .font(.system(size: 10))
                            .offset(y: self.offsetY)
                    )
            }
                .frame(width: 60, height: geo.size.height)
                .background(Color.red.opacity(0.15))
                .onTapGesture {
                    print("Hellw")
                }
            }
            .background(Color.secondary.opacity(0.1))
            .offset(self.offset)
            .animation(.spring())
            .gesture(DragGesture()
                        .onChanged { gestrue in
                            self.offset.width = gestrue.translation.width
                        }
                        .onEnded { _ in
                            if self.offset.width < -50 {
                                    self.scale = 1
                                self.offset.width = -120
                                self.offsetY = -20
                            } else {
                                    self.scale = 0.5
                                self.offset = .zero
                                self.offsetY = 0

                            }
                        }
            )
        }
    }
}
struct ContentView: View {
    @State var array = ["First Text", "Second Text", "Third Text"]
    @State var indices : [Int] = []
    var body: some View {
        GeometryReader { geo in
            VStack {
                Text("My List")
                    .font(.system(size: 40))
                    .bold()
                    .frame(width: geo.size.width * 0.95, alignment: .leading)
                    .padding(.top, 50)
                ScrollView {
                    LazyVStack(spacing: 1) {
                        ForEach (0..<array.count, id: \.self) { index in
                            if !indices.contains(index) {
                                RowContent(text: array[index], index: index, indices : $indices)
                                    .frame(height: 60)
                            }
                        }
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
