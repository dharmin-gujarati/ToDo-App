

import SwiftUI
import CoreData

struct todofull_home: View {
    @State private var selectedTab = 0
    
    
    @Environment(\.managedObjectContext) private var context
    let tabs = ["Behind Schedule", "Upcoming", "Completed"]
    @State private var searchText = ""
    @State private var showSheet = false
    @State private var tasktitle = ""
    @State private var date : Date = Date()
    @State private var showSheet2 = false
    @State private var goto = false
    @AppStorage("isDarkMode") var isDarkMode: Bool = false
    @State var todayDay : Int = Int(Date().formatted(Date.FormatStyle().day())) ?? 0
    @State private var upComing = false
    @State private var selectedDay = 1
    @State private var selectedTask: UserDetails? = nil
    @State private var isEditing = false
    
    @FetchRequest(sortDescriptors: [] , animation: .default)
    private var userArray : FetchedResults<UserDetails>
    
    var body: some View {
        NavigationStack{
            HStack{
                Button(action :{
                    print("\(todayDay)")
                }) {
                    Image(systemName: "line.3.horizontal")
                        .resizable()
                        .frame(width: 25.0, height: 20.0)
                }
                .padding(.leading)
                
                NavigationLink("", destination: todofull_login(), isActive: $goto)
                VStack {
                    HStack{
                        Circle()
                            .fill(Color(red: 0.145, green: 0.388, blue: 0.922))
                            .frame(width: 50)
                        
                            .overlay {
                                Image(systemName: "checkmark")
                                    .resizable()
                                    .frame(width: 20.0, height: 20.0)
                                    .colorInvert()
                            }
                        Text("ToDo")
                            .bold()
                            .font(.title)
                            .foregroundStyle(Color(red: 0.145, green: 0.388, blue: 0.922))
                        Spacer()
                        HStack {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.gray)
                            
                            TextField("Search", text: $searchText)
                                .frame(width:132)
                            
                            if !searchText.isEmpty {
                                Button {
                                    searchText = ""
                                } label: {
                                    Image(systemName: "xmark.circle.fill")
                                        .foregroundColor(.gray)
                                }
                            }
                        }
                        .padding(10)
                        .background(Color(.systemGray6))
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color.gray.opacity(0.4), lineWidth: 1)
                        )
                        .cornerRadius(12)
                        .padding()
                    }
                }
            }
            
            VStack {
                Toggle("Dark Mode", isOn: $isDarkMode)
                Picker("", selection: $selectedTab) {
                    Text("Behind Schedule").tag(0)
                    Text("Upcoming").tag(1)
                    Text("Completed").tag(2)
                }
                .pickerStyle(.segmented)
                .padding()
                
                TabView(selection: $selectedTab) {
                    VStack{
                        ScrollView {
                            ForEach(Array(userArray.enumerated()), id: \.element) { index, user in
                                
                                if todayDay == getDayInt(user.time ?? "")
                                {
                                    if !user.taskMark{
                                        taskView(user)
                                    }
                                }
                                
                            }
                        }
                    }.tag(0)
                    VStack{
                        ScrollView {
                            ForEach(Array(userArray.enumerated()), id: \.element) { index, user in
                                
                                if todayDay != getDayInt(user.time ?? "")
                                {
                                    taskView(user)
                                }
                            }
                        }
                    }.tag(1)
                    VStack{
                        ScrollView {
                            ForEach(Array(userArray.enumerated()), id: \.element) { index, user in
                                
                                if user.taskMark && todayDay == getDayInt(user.time ?? ""){
                                    taskView(user)
                                }
                            }
                        }
                    }.tag(2)
                    
                    
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
            }
            HStack{
                Spacer()
                Button(action: {
                    showSheet = true
                    date = Date()
                    tasktitle = ""
                }) {
                    Image(systemName: "plus")
                        .foregroundColor(.white)
                        .font(.title)
                        .frame(width: 60, height: 60)
                        .background(Color.blue)
                        .clipShape(Circle())
                }
                .padding()
                
            }
            
        }
        .navigationBarBackButtonHidden(true)
        
        .sheet(isPresented: $showSheet) {
            VStack(spacing : 50){
                HStack {
                    Text("Create a Task")
                        .font(.title)
                    
                    Spacer()
                }
                .padding()
                .presentationDetents([.medium, .large])
                TextField("Task Title", text: $tasktitle)
                
                    .bold()
                    .font(.system(size: 20))
                    .padding([.top, .bottom, .trailing], 50)
                    .padding(.leading, 15)
                    .background(Color(red: 0.91, green: 0.91, blue: 0.914))
                    .frame(width: 395,height: 50)
                    .cornerRadius(10)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()
                
                DatePicker("date", selection: $date , in: Date()..., displayedComponents: [.date,.hourAndMinute] )
                Button(action: {
                    
                    if tasktitle != ""{
                        if isEditing {
                            updateTask()
                        } else {
                            saveData()
                        }
                        
                        showSheet2 = true
                        showSheet = false
                        
                    }else{
                        showSheet = false
                    }
                }) {
                    Text(isEditing ? "Update Task" : "Create Task")
                }
                .frame(width: 390 , height: 70)
                .background(Color(red: 0.145, green: 0.388, blue: 0.922))
                .foregroundColor(.white)
                .cornerRadius(15)
                .font(.largeTitle)
                
            }
        }
        .sheet(isPresented: $showSheet2) {
            VStack{
                
                Circle()
                    .fill(Color(red: 0.145, green: 0.388, blue: 0.922))
                    .frame(width: 150)
                    .overlay {
                        Image(systemName: "checkmark")
                            .resizable()
                            .frame(width: 75, height: 75)
                            .colorInvert()
                    }
                    .presentationDetents([.medium, .large])
                    .padding(.bottom, 40.0)
                Text("successful")
                    .bold()
                    .foregroundColor(.green)
                    .font(.system(size: 25))
                Text("you have successfully created task")
                    .frame(width: 200)
                    .foregroundColor(Color(red: 0.561, green: 0.588, blue: 0.627))
                    .font(.system(size: 15))
                    .padding(.bottom, 50)
                    .multilineTextAlignment(.center)
                
                Button(action: {
                    
                    showSheet2 = false
                    isEditing = false
                    selectedTask = nil
                    
                }) {
                    Text("Done")
                }
                .frame(width: 390 , height: 70)
                .background(Color(red: 0.145, green: 0.388, blue: 0.922))
                .foregroundColor(.white)
                .cornerRadius(15)
                .font(.largeTitle)
            }
        }
        
    }
    func saveData() {
        
        let user = UserDetails(context: context)
        user.title = tasktitle
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy HH:mm"
        formatter.timeZone = .current
        user.time = formatter.string(from: date)
        do {
            try context.save()
        } catch {
            print("Failed to save data: \(error)")
        }
    }
    @ViewBuilder
    func taskView(_ user: UserDetails) -> some View {
        Rectangle()
            .fill(.white)
            .border(Color.black, width: 2)
            .frame(height: 100)
            .overlay {
                HStack {
                    
                    Button {
                        user.taskMark.toggle()
                        try? context.save()
                    } label: {
                        if todayDay ==  getDayInt(user.time ?? ""){
                            Image(systemName: user.taskMark ? "checkmark.circle.fill" : "checkmark.circle")
                                .resizable()
                                .frame(width: 40, height: 40)
                        }else{
                            Image(systemName: "")
                                .resizable()
                                .frame(width: 40, height: 40)
                        }
                        
                    }
                    .padding()
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text(user.title ?? "")
                            .foregroundColor(.gray)
                        
                        Text(user.time ?? "")
                            .foregroundColor(.red)
                    }
                    Spacer()
                    Button {
                        selectedTask = user
                        tasktitle = user.title ?? ""
                        
                        if let timeString = user.time {
                            let formatter = DateFormatter()
                            formatter.dateFormat = "dd-MM-yyyy HH:mm"
                            formatter.locale = Locale(identifier: "en_US_POSIX")
                            
                            if let convertedDate = formatter.date(from: timeString) {
                                date = convertedDate
                            }
                        }
                        
                        isEditing = true
                        showSheet = true
                    } label: {
                        Image(systemName: "square.and.pencil.circle")
                            .resizable()
                            .frame(width: 40, height: 40)
                    }
                    Button {
                        deleteTask(user)
                    } label: {
                        Image(systemName: "trash.circle.fill")
                            .resizable()
                            .frame(width: 40, height: 40)
                    }
                    .padding(.trailing, 10.0)
                    
                    
                }
            }
            .padding(.horizontal)
    }
    
    func getDayInt(_ dateString: String) -> Int {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy HH:mm"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        
        if let date = formatter.date(from: dateString) {
            return Calendar.current.component(.day, from: date)
        }
        
        return 0
    }
    func updateTask() {
        guard let task = selectedTask else { return }
        
        task.title = tasktitle
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy HH:mm"
        formatter.timeZone = .current
        
        task.time = formatter.string(from: date)
        
        do {
            try context.save()
        } catch {
            print("Failed to update data: \(error)")
        }
        
        isEditing = false
        selectedTask = nil
    }
    func deleteTask(_ task: UserDetails) {
        context.delete(task)
        
        do {
            try context.save()
        } catch {
            print("Failed to delete task: \(error)")
        }
    }
    
}

#Preview {
    todofull_home()
}
