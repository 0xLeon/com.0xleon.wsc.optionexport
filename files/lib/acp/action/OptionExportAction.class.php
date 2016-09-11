<?php
namespace wcf\acp\action;
use wcf\action\AbstractAction;
use wcf\data\option\Option;
use wcf\util\JSON;

/**
 * Exports the options to an XML.
 * 
 * @author	Marcel Werk, Stefan Hahn
 * @copyright	2016 Stefan Hahn
 * @copyright	2001-2015 WoltLab GmbH
 * @license	GNU Lesser General Public License <http://opensource.org/licenses/lgpl-license.php>
 * @package	com.0xleon.wsc.optionexport
 */
class OptionExportAction extends AbstractAction {
	/**
	 * @inheritDoc
	 */
	public $neededPermissions = ['admin.configuration.canEditOption'];
	
	/**
	 * @inheritDoc
	 */
	public function execute() {
		parent::execute();
		
		// header
		@header('Content-type: application/json');
		
		// file name
		@header('Content-disposition: attachment; filename="options-' . gmdate('Y-m-d-H-i-s', TIME_NOW) . '.json"');
			
		// no cache headers
		@header('Pragma: no-cache');
		@header('Expires: 0');
		
		$options = Option::getOptions();
		$outputOptions = [];
		
		foreach ($options as $option) {
			if ($option->hidden) continue;
			
			$outputOptions[$option->optionName] = $option->optionValue;
		}
		
		echo JSON::encode($outputOptions, JSON_PRETTY_PRINT);
		
		$this->executed();
		exit;
	}
}
