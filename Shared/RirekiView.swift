
import SwiftUI
import RealmSwift


struct RirekiView: View {
    
    @ObservedObject var model = viewModel()
    @State var condition : Bool = false
    var id = ""
    var lapsuu : Int = 0
    var lapcount = Array(1...99)
    var kirokuday = Date()
    var Rirekitotal : String = ""
    var finalLap : String = ""
    var tickets = RealmSwift.List<String>()
    var ticketsTotal = RealmSwift.List<String>()

    var dateFormat: DateFormatter {
        let dformat = DateFormatter()
        dformat.dateFormat = "yyyy/M/d"
        return dformat
    }
    
    var dateFormat2: DateFormatter {
        let dformat = DateFormatter()
        dformat.dateFormat = "hh時mm分"
        return dformat
    }
    
    var body: some View {
        ZStack{
            LinearGradient(gradient: Gradient(colors: [.white, .green]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            VStack{
                Text("保存日時").font(.title2)
                HStack{
                    Text("\(dateFormat.string(from: kirokuday))").font(.largeTitle)
                    Text(" \(dateFormat2.string(from: kirokuday))").font(.largeTitle)
                    
                }
                Spacer().frame(height: 10)
                HStack{
                    VStack{
                        HStack{
                    VStack{
                        Text("Total").font(.title2)
                        Text("Time").font(.title2)
                    }
                    Text("\(Rirekitotal)")
                        .font(Font.custom("HiraginoSans-W3", size: 50))
                        .font(.system(size: 50, design: .monospaced))
                        }
                        Rectangle()
                                .foregroundColor(.orange)
                                .frame(width: 250, height: 1)
                        Spacer().frame(height: 10)
                HStack{
                    VStack {
                        Text("Final").font(.title3)
                        Text("Lap").font(.title3)
                    }.padding(5)
                        .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(Color.black, lineWidth: 1)
)
                    Text("\(finalLap)")
                        .font(Font.custom("HiraginoSans-W3", size: 50))
                        .font(.system(size: 50, design: .monospaced))
                }}
                        Button(action: {
                            condition.toggle()
                        }){
                            VStack{
                        if condition == true {
                            Image(systemName: "heart.fill").font(.title)
                                .foregroundColor(.pink)
                        } else {
                            Image(systemName: "heart.fill").font(.title)
                                .foregroundColor(.secondary)
                        }
                                Text("favorite").font(.system(size: 13))
                            }}}
                List {
                    ForEach(0 ..< lapsuu, id: \.self) { cellModel in
                        HStack(spacing:2){
                            VStack{
                                Text("Lap")
                                    .font(.system(size: 15, design: .monospaced))
                                Text("\(lapsuu - lapcount[cellModel] + 1)")
                                //                        Text(lapNo[cellModel])
                                    .font(.system(size: 25, design: .monospaced))
                            }
                            .overlay(
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(Color.black, lineWidth: 1)
                            )
                            Spacer()
                            Text("\(tickets[cellModel])")
                                .font(Font.custom("HiraginoSans-W3", size: 50))
                                .font(.system(size: 50, design: .monospaced))
                            Spacer()
                            Text("\(ticketsTotal[cellModel])")
                                .font(Font.custom("HiraginoSans-W3", size: 20))
                                .font(.system(size: 20, design: .monospaced))
                        }
                        .listRowInsets(EdgeInsets())
                        .listRowBackground(Color("ColorOrange2"))
                        //                            .listRowBackground(Color.clear)
                        .listRowInsets(EdgeInsets(top: 3, leading: 0, bottom: 3, trailing: 0))
                    }
                }                .environment(\.defaultMinListRowHeight, 70)
                    .listStyle(PlainListStyle())
                    .font(.largeTitle)
            }
        }.navigationBarTitleDisplayMode(.inline)
            .onDisappear {
                
                let realm = try! Realm()
                let predicate = NSPredicate(format: "id == %@", id as CVarArg)
                let results = realm.objects(Model.self).filter(predicate).first
                try! realm.write {
                    results?.condition = condition
                }
            }
    }}
