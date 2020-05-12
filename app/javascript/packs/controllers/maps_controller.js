import { Controller } from "stimulus"
import L from 'leaflet'

export default class extends Controller {
    connect() {
        let mapId = this.targets.find('container').id
        let sets = this.targets.find('routes').textContent

        this.webpack_icon_fix() // see function comments

        let map = this.init(mapId)
        this.load_route(map, sets)
    }

    init(mapId) {
        let layers = this.init_layers()

        let map = L.map(mapId, {
            center: new L.LatLng(39.8, -98.6),
            zoom: 4,
            layers: layers['baseMaps']['Grayscale']
        })

        L.control.layers(layers['baseMaps']).addTo(map)

        return map
    }

    init_layers() {
        let baseMaps = {}

        baseMaps['Color'] = L.tileLayer(
            'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
            {
                attribution: '&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors'
            }
        )

        baseMaps['Grayscale'] = L.tileLayer(
            'https://cartodb-basemaps-{s}.global.ssl.fastly.net/light_all/{z}/{x}/{y}.png',
            {
                attribution: '&copy; <a href="https://carto.com/attribution">CARTO</a>'
            }
        )

        return {baseMaps: baseMaps}
    }

    // Routes json is:
    // [ set [ segment [marker] ] ]
    // [ [ [:lat, :lng, :label], [:lat, :lng, :label] ] ]
    //
    load_route(map, json) {
        let set     = JSON.parse(json)
        let markers = []

        if (set === null){ return }

        set.forEach(function(segment,index){
            let latlngs = []

            segment.forEach(function(location, index){
                latlngs.push([location.lat, location.lng])

                let marker = L.marker([location.lat, location.lng]).addTo(map)
                marker.bindPopup("<b>" + location.label + "</b>")

                markers.push(marker)
            })

            L.polyline(latlngs, {color: '#0b375b'}).addTo(map)
        })

        let group = L.featureGroup(markers)
        map.fitBounds(group.getBounds())
    }

    // This is a patch to fix incorrectly resolved default icons
    // https://stackoverflow.com/questions/41144319/leaflet-marker-not-found-production-env
    //
    webpack_icon_fix() {
        delete L.Icon.Default.prototype._getIconUrl;
        L.Icon.Default.mergeOptions({
            iconRetinaUrl: require("leaflet/dist/images/marker-icon-2x.png"),
            iconUrl: require("leaflet/dist/images/marker-icon.png"),
            shadowUrl: require("leaflet/dist/images/marker-shadow.png")
        });
    }
}
