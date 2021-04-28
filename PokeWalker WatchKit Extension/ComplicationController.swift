//
//  ComplicationController.swift
//  PDC Hatch WatchKit Extension
//
//  Created by Adrian Impedovo on 15/3/21.
//

import ClockKit
import SwiftUI

class ComplicationController: NSObject, CLKComplicationDataSource {
    
    // MARK: - Complication Configuration

    func getComplicationDescriptors(handler: @escaping ([CLKComplicationDescriptor]) -> Void) {
        let descriptors = [
            CLKComplicationDescriptor(identifier: "complication", displayName: "Partner Summary", supportedFamilies: [CLKComplicationFamily.graphicRectangular])
            // Multiple complication support can be added here with more descriptors
        ]
        
        // Call the handler with the currently supported complication descriptors
        handler(descriptors)
    }
    
    func handleSharedComplicationDescriptors(_ complicationDescriptors: [CLKComplicationDescriptor]) {
        // Do any necessary work to support these newly shared complication descriptors
    }

    // MARK: - Timeline Configuration
    
    func getTimelineEndDate(for complication: CLKComplication, withHandler handler: @escaping (Date?) -> Void) {
        // Call the handler with the last entry date you can currently provide or nil if you can't support future timelines
        handler(Date(timeIntervalSinceNow: 60 * 5))
    }
    
    func getPrivacyBehavior(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationPrivacyBehavior) -> Void) {
        // Call the handler with your desired behavior when the device is locked
        handler(.showOnLockScreen)
    }

    // MARK: - Timeline Population
    
    func getCurrentTimelineEntry(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTimelineEntry?) -> Void) {
        // Call the handler with the current timeline entry
        let template =        CLKComplicationTemplateGraphicRectangularFullView(ComplicationView())
        handler(CLKComplicationTimelineEntry(date: Date(), complicationTemplate: template))
    }
    
    func getTimelineEntries(for complication: CLKComplication, after date: Date, limit: Int, withHandler handler: @escaping ([CLKComplicationTimelineEntry]?) -> Void) {
        // Call the handler with the timeline entries after the given date
        handler(nil)
    }

    // MARK: - Sample Templates
    
    func getLocalizableSampleTemplate(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTemplate?) -> Void) {
        // This method will be called once per supported complication, and the results will be cached
        handler(CLKComplicationTemplateGraphicRectangularFullView(ComplicationViewTemplate()))
    }
}

struct ComplicationController_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CLKComplicationTemplateGraphicRectangularFullView(ComplicationViewTemplate()).previewContext()
        }
    }
}

struct ComplicationView: View {
    @State var partner: Pokemon = User.Player.pokemon[0]
    
    var body: some View {
        HStack {
            HStack {
                Image(partner.getIconString())
                    .interpolation(.none)
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 60, height: 56, alignment: .leading)
            }.frame(width: 60, height: 56, alignment: .leading)
            Spacer(minLength: 10)
            VStack(alignment: .leading) {
                Text(partner.getName()).bold().font(.body).alignmentGuide(.leading, computeValue: { d in d[.leading]
                })
                Text("\(partner.steps) steps").font(.caption2).alignmentGuide(.leading, computeValue: { d in d[.leading]
                })
                if (!partner.isEgg()) {
                    Text("Level " + partner.getLevelString()).font(.caption2).alignmentGuide(.leading, computeValue: { d in d[.leading]
                    })
                }
            }.frame(width: 110, alignment: .leading)
        }
    }
}

struct ComplicationViewTemplate: View {
    var body: some View {
        HStack {
            HStack {
                Image("14gi")
                    .interpolation(.none)
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 60, height: 56, alignment: .leading)
            }.frame(width: 60, height: 56, alignment: .leading)
            Spacer(minLength: 10)
            VStack(alignment: .leading) {
                Text("Pikachu").bold().font(.body).alignmentGuide(.leading, computeValue: { d in d[.leading]
                })
                Text("9,999,999 steps").font(.caption2).alignmentGuide(.leading, computeValue: { d in d[.leading]
                })
                Text("Level 00").font(.caption2).alignmentGuide(.leading, computeValue: { d in d[.leading]
                })
            }.frame(width: 110, alignment: .leading)
        }
    }
}
