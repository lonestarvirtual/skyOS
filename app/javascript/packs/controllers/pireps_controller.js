import { Controller } from "stimulus"
import Rails from "@rails/ujs"

export default class extends Controller {
    find_destination(event) {
        var icao = this.targets.find('dest_icao')
        var name = this.targets.find('dest')
        this.find_airport(icao, name)
    }

    find_origin(event) {
        var icao = this.targets.find('orig_icao')
        var name = this.targets.find('orig')
        this.find_airport(icao, name)
    }

    find_airport(icao_control, name_control) {
        var icao = icao_control.value

        if (icao.length > 2) {
            Rails.ajax({
                url: '/api/v1/airports/' + icao,
                type: 'get',
                data: '',
                success: function (data) {
                    if (data != null) {
                        name_control.value = data['name']
                        icao_control.classList.add('is-valid')
                        name_control.classList.add('is-valid')
                    } else {
                        name_control.value = null
                        icao_control.classList.remove('is-valid')
                        name_control.classList.remove('is-valid')
                    }
                }
            })
        } else {
            name_control.value = null
            icao_control.classList.remove('is-valid')
            name_control.classList.remove('is-valid')
        }
    }
}
